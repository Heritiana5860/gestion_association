import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateChecker {
  static const owner = "Heritiana5860";
  static const repo = "gestion_association";

  static Future<Map<String, dynamic>?> checkForUpdate(
    BuildContext context,
  ) async {
    if (!Platform.isAndroid) return null;

    try {
      final response = await http.get(
        Uri.parse("https://api.github.com/repos/$owner/$repo/releases/latest"),
      );
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);
      final rawTag = data["tag_name"] as String;
      final latestVersion = _cleanVersion(rawTag);

      final currentInfo = await PackageInfo.fromPlatform();
      final currentVersion = currentInfo.version;

      if (_isNewer(latestVersion, currentVersion)) {
        final apkAsset = (data["assets"] as List).firstWhere(
          (a) => a["name"].toString().endsWith(".apk"),
          orElse: () => null,
        );
        if (apkAsset != null) {
          return {
            "version": latestVersion,
            "url": apkAsset["browser_download_url"],
            "changelog": data["body"] ?? "",
          };
        }
      }
      return null;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.red,
            content: AppText(label: "Erreur: $e"),
          ),
        );
      }
      return null;
    }
  }

  /// Ne garde que le préfixe numérique (ex: "v1.2.0-beta+3" -> "1.2.0")
  static String _cleanVersion(String tag) {
    final match = RegExp(r'\d+(\.\d+)*').firstMatch(tag);
    return match?.group(0) ?? "0.0.0";
  }

  static bool _isNewer(String remote, String local) {
    final r = remote.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final l = local.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final len = r.length > l.length ? r.length : l.length;

    for (int i = 0; i < len; i++) {
      final rv = i < r.length ? r[i] : 0;
      final lv = i < l.length ? l[i] : 0;
      if (rv > lv) return true;
      if (rv < lv) return false;
    }
    return false;
  }

  static Future<void> downloadAndInstall({
    required BuildContext context,
    required String url,
  }) async {
    if (!Platform.isAndroid) return;

    // Vérifie et demande la permission d'installer des apps inconnues
    var status = await Permission.requestInstallPackages.status;
    if (!status.isGranted) {
      status = await Permission.requestInstallPackages.request();
      if (!status.isGranted) {
        // permission refusée : impossible de continuer
        return;
      }
    }

    try {
      final dir = await getExternalStorageDirectory();
      if (dir == null) return;

      final filePath = "${dir.path}/update.apk";
      final file = File(filePath);

      // Nettoie un éventuel ancien fichier
      if (await file.exists()) {
        await file.delete();
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return; // téléchargement échoué, ne pas installer un fichier corrompu
      }

      await file.writeAsBytes(response.bodyBytes);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AppText(
              label:
                  "L'application va se fermer. Relancez-la après l'installation.",
            ),
          ),
        );
      }

      await OpenFilex.open(filePath); // lance l'installeur système

      // Ferme l'app pour forcer l'utilisateur à relancer la nouvelle version
      if (Platform.isAndroid) {
        await SystemNavigator.pop(); // ou exit(0) si tu veux être plus radical
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.red,
            content: AppText(label: "Erreur: $e"),
          ),
        );
      }
    }
  }
}
