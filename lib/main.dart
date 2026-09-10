import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/routes/config.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/services/notification_service.dart';
import 'package:login_with_unite_test_and_clean_architecture/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  // final url = dotenv.env['url'] ?? "";

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await NotificationService().initialize(baseUrl: url);

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // runApp(ProviderScope(child: MyApp()));
  
  runApp(const ProviderScope(child: Bootstrap()));
}

class Bootstrap extends StatefulWidget {
  const Bootstrap({super.key});

  @override
  State<Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<Bootstrap> {
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    // On lance l'init une seule fois (pas à chaque rebuild).
    _initFuture = _init();
  }

  Future<void> _init() async {
    await dotenv.load();
    final url = dotenv.env['url'] ?? "";

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await NotificationService().initialize(baseUrl: url);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _SplashScreen();
        }

        if (snapshot.hasError) {
          return _ErrorScreen(error: snapshot.error);
        }

        return const MyApp();
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(child: CircularProgressIndicator(color: AppColor.blue)),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text("Erreur d'initialisation : $error")),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColor.white,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
            ),
          ),
          routerConfig: router,
        );
      },
    );
  }
}
