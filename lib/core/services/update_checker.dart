import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateChecker {
  static const owner = "ton-user-github";
  static const repo = "ton-repo";

  static Future<Map<String, dynamic>?> checkForUpdate() async {
    final response = await http.get(
      Uri.parse("https://api.github.com/repos/$owner/$repo/releases/latest"),
    );
    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    final latestVersion = (data["tag_name"] as String).replaceAll("v", "");

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
  }

  static bool _isNewer(String remote, String local) {
    final r = remote.split('.').map(int.parse).toList();
    final l = local.split('.').map(int.parse).toList();
    for (int i = 0; i < r.length; i++) {
      if (i >= l.length || r[i] > l[i]) return true;
      if (r[i] < l[i]) return false;
    }
    return false;
  }

  static Future<void> downloadAndInstall(String url) async {
    if (await Permission.requestInstallPackages.isDenied) {
      await Permission.requestInstallPackages.request();
    }

    final dir = await getExternalStorageDirectory();
    final filePath = "${dir!.path}/update.apk";

    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    await OpenFilex.open(filePath); // lance l'installeur système
  }
}
