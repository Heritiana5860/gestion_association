import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_font.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_height.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/errors/error_message.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/list_animated.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/login/auth_login_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/logo.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/sociaux_card.dart';

class AuthLoginPage extends ConsumerStatefulWidget {
  const AuthLoginPage({super.key});

  @override
  ConsumerState<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends ConsumerState<AuthLoginPage> {
  final formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapRecognizer;
  bool isVisibled = true;

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _handleTap;
  }

  void _handleTap() {
    context.goNamed(RouteKeys.inscriptionName);
  }

  void _submit() {
    final model = AuthModel(
      username: username.text.trim(),
      password: password.text,
    );
    if (formKey.currentState!.validate()) {
      ref.read(login.notifier).signIn(model: model);
      clear();
    }
  }

  void clear() {
    username.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(login);
    final isLoading = auth is AsyncLoading;

    ref.listen<AsyncValue<void>>(login, (previous, next) {
      next.whenOrNull(
        data: (data) => context.goNamed(RouteKeys.homeName),
        error: (error, _) => ErrorMessage(),
      );
    });

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizePadding.globalPadding),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: ListAnimated(
                  children: [
                    Logo(),

                    SizedBox(height: SizeHeight.twentyHeight),

                    AppText(
                      label: "Login to your account",
                      color: AppColor.textDescription,
                      fontSize: SizeFont.medium,
                      fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: SizeHeight.twentyFourHeight),

                    AppInput(
                      controller: username,
                      labelText: "Nom d'utilisateur",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.text,
                      validator: (valeur) {
                        if (valeur == null) {
                          return "Ce champ est obligatoir.";
                        }

                        if (valeur.length < 2) {
                          return "Nom d'utilisateur doit être plus de 2 caractères.";
                        }

                        final specialPattern = RegExp(
                          r'[^\w\s]',
                          caseSensitive: true,
                        );

                        if (specialPattern.hasMatch(valeur)) {
                          return "Le nom d'utilisateur ne peut pas contenir de caractère speciaux.";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: SizeHeight.tenHeight),
                    AppInput(
                      controller: password,
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
                        if (value == null) {
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
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SociauxCard(
                              imagePath: "assets/sociaux/gmail.svg",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SociauxCard(
                              imagePath: "assets/sociaux/twitter.svg",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: SizeHeight.twentyFourHeight),

                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.dmSans(
                          color: AppColor.textDescription,
                          fontSize: SizeFont.medium,
                        ),
                        children: [
                          const TextSpan(text: "Don't have an account yet? "),
                          TextSpan(
                            text: "Sign up",
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
    _tapRecognizer.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
