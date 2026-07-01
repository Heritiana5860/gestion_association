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
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/auth/header_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/list_animated.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/register/register_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/logo.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/widgets/sociaux_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/providers/obligation_notifier.dart';

class AuthRegisterPage extends ConsumerStatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  ConsumerState<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends ConsumerState<AuthRegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool isVisibled = true;
  bool isConfirmVisibled = true;
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

  void _submit() {
    final model = AuthRegisterModel(
      fullName: fullName.text.trim(),
      username: username.text.trim(),
      password: password.text,
    );

    if (formKey.currentState!.validate()) {
      ref.read(newUserProvider.notifier).createNewUser(model: model);
    }
  }

  void clear() {
    fullName.clear();
    username.clear();
    password.clear();
    confirm.clear();
  }

  @override
  Widget build(BuildContext context) {
    final newUser = ref.watch(newUserProvider);
    final isLoading = newUser is AsyncLoading;

    ref.listen<AsyncValue<void>>(newUserProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          clear();

          ref.read(obligationsProvider.notifier).refresh();
          ref.read(memberDataStats.notifier).refresh();
          ref.watch(cotisationStats.notifier).refresh();

          context.goNamed(RouteKeys.homeName);
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.red,
              content: AppText(label: "$error", color: AppColor.white),
            ),
          );
        },
      );
    });

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
                      controller: fullName,
                      enabled: !isLoading,
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
                      enabled: !isLoading,
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
                      enabled: !isLoading,
                      labelText: "Confirme mot de passe",
                      prefixIcon: Icons.lock,
                      obscureText: isConfirmVisibled,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmVisibled = !isConfirmVisibled;
                          });
                        },
                        icon: Icon(
                          isConfirmVisibled
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                      label: isLoading ? "Création..." : "Créer compte",
                      onPressed: isLoading ? null : _submit,
                    ),

                    SizedBox(height: SizeHeight.twentyFourHeight),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: AppText(
                            label: "Ou",
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
                        style: GoogleFonts.inter(
                          color: AppColor.textDescription,
                          fontSize: SizeFont.medium,
                        ),
                        children: [
                          const TextSpan(text: "Vous avez déjà un compte ? "),
                          TextSpan(
                            text: "Se connecter",
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
    fullName.dispose();
    username.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }
}
