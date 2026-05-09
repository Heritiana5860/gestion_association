import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/list_animated.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/logo.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/sociaux_card.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool isVisibled = true;
  late TapGestureRecognizer _tapRecognizer;

  final fullName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _handleTap;
  }

  void _handleTap() {
    context.goNamed(RouteKeys.loginName);
  }

  @override
  Widget build(BuildContext context) {
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
                      label: "Create your account",
                      color: AppColor.textDescription,
                      fontSize: SizeFont.medium,
                      fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: SizeHeight.twentyFourHeight),
                    AppInput(
                      controller: fullName,
                      labelText: "Nom complet",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.text,
                      validator: (valeur) {
                        if (valeur == null) {
                          return "Ce champ est obligatoir.";
                        }

                        if (valeur.length < 2) {
                          return "Nom doit être plus de 2 caractères.";
                        }

                        final specialPattern = RegExp(
                          r'[^\w\s]',
                          caseSensitive: true,
                        );

                        if (specialPattern.hasMatch(valeur)) {
                          return "Le nom ne peut pas contenir de caractère speciaux.";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: SizeHeight.tenHeight),
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

                        if (password.text != confirm.text) {
                          return "Mot de passe doit être les mêmes.";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: SizeHeight.tenHeight),
                    AppInput(
                      controller: confirm,
                      labelText: "Confirme mot de passe",
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

                        if (password.text != confirm.text) {
                          return "Mot de passe doit être les mêmes.";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: SizeHeight.twentyHeight),

                    AppButton(
                      label: "Sign up",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
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
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: "Sign in.",
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
    super.dispose();
  }
}
