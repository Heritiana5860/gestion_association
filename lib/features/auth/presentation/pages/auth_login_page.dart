import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_font.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_height.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/auth/header_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/list_animated.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/login/auth_login_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/logo.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/sociaux_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/obligation_notifier.dart';

class AuthLoginPage extends ConsumerStatefulWidget {
  const AuthLoginPage({super.key});

  @override
  ConsumerState<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends ConsumerState<AuthLoginPage> {
  final formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapRecognizer;
  bool isVisibled = true;

  late final TextEditingController username;
  late final TextEditingController password;

  late final ProviderSubscription<AsyncValue<AuthSessionEntity?>>
  _loginSubscription;

  @override
  void initState() {
    super.initState();

    username = TextEditingController();
    password = TextEditingController();

    _tapRecognizer = TapGestureRecognizer()..onTap = _handleTap;

    _loginSubscription = ref.listenManual(loginProvider, (previous, next) {
      next.whenOrNull(
        data: (_) async {
          if (!context.mounted) return;
          context.goNamed(RouteKeys.homeName);

          final obligationsNotifier = ref.read(obligationsProvider.notifier);
          final memberStatsNotifier = ref.read(memberDataStats.notifier);
          final cotisationStatsNotifier = ref.read(cotisationStats.notifier);

          await Future.wait([
            obligationsNotifier.refresh(),
            memberStatsNotifier.refresh(),
            cotisationStatsNotifier.refresh(),
          ]);
        },
        error: (error, _) {
          final message = error is Failure
              ? error.message
              : "Une erreur est survenue.";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.red,
              content: AppText(label: message, color: AppColor.white),
            ),
          );
        },
      );
    });
  }

  void _handleTap() {
    context.goNamed(RouteKeys.inscriptionName);
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    final params = LoginParams(
      username: username.text.trim(),
      password: password.text,
    );
    ref.read(loginProvider.notifier).signIn(entity: params);
  }

  void clear() {
    username.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(loginProvider);
    final isLoading = auth is AsyncLoading;

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: globalPadding(),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: ListAnimated(
                  children: [
                    Logo(),

                    HeaderText(),

                    SizedBox(height: SizeHeight.twentyFourHeight),

                    AppInput(
                      controller: username,
                      enabled: !isLoading,
                      labelText: "Nom d'utilisateur",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Ce champ est obligatoir.";
                        }

                        if (value.length < 2) {
                          return "Nom d'utilisateur doit être plus de 2 caractères.";
                        }

                        final specialPattern = RegExp(
                          r'[^\w\s]',
                          caseSensitive: true,
                        );

                        if (specialPattern.hasMatch(value)) {
                          return "Le nom d'utilisateur ne peut pas contenir de caractère speciaux.";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: SizeHeight.tenHeight),
                    AppInput(
                      controller: password,
                      enabled: !isLoading,
                      labelText: "Mot de passe",
                      prefixIcon: Icons.lock,
                      obscureText: isVisibled,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisibled = !isVisibled;
                          });
                        },
                        icon: Icon(
                          isVisibled ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Ce champ est obligatoir.";
                        }

                        if (value.length < 6) {
                          return "Mot de passe doit être plus de 6 caractère.";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: SizeHeight.twentyHeight),

                    AppButton(
                      label: isLoading ? "Connexion..." : "Se connecter",
                      onPressed: isLoading ? null : _submit,
                    ),

                    SizedBox(height: SizeHeight.twentyFourHeight),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: AppText(
                            label: "Or",
                            color: AppColor.textDescription,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    SizedBox(height: SizeHeight.twentyHeight),

                    SizedBox(
                      height: 70.h,
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            child: SociauxCard(
                              imagePath: "assets/sociaux/facebook.svg",
                              onTap: _aVenir,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SociauxCard(
                              imagePath: "assets/sociaux/gmail.svg",
                              onTap: _aVenir,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SociauxCard(
                              imagePath: "assets/sociaux/twitter.svg",
                              onTap: _aVenir,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: SizeHeight.twentyFourHeight),

                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: AppColor.textDescription,
                          fontSize: SizeFont.medium,
                        ),
                        children: [
                          const TextSpan(
                            text: "Vous n'avez pas encore de compte ? ",
                          ),
                          TextSpan(
                            text: "Créer un compte",
                            recognizer: _tapRecognizer,
                            style: TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginSubscription.close();
    _tapRecognizer.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void _aVenir() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.blue,
        content: AppText(
          label: "Fonctionnalité reste à venir!",
          color: AppColor.white,
        ),
      ),
    );
  }
}
