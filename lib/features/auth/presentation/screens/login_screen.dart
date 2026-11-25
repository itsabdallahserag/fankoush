import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/constants/validators.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/theme/app_text_styles.dart';
import 'package:fankoush/core/utils/app_snackbar.dart';
import 'package:fankoush/shared/widgets/custom_checkbox_tile.dart';
import 'package:fankoush/shared/widgets/custom_text_field.dart';
import 'package:fankoush/features/auth/logic/auth_cubit.dart';
import 'package:fankoush/features/auth/logic/auth_state.dart';
import 'package:fankoush/features/auth/presentation/screens/auth_widgets/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  const _LoginScreenContent();

  @override
  State<_LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<_LoginScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                Navigator.pushReplacementNamed(context, AppRoutes.plans);
              } else if (state.status == AuthStatus.failure) {
                AppSnackBar.showError(
                  context,
                  state.errorMessage ?? AppStrings.loginError,
                );
              }
            },
            builder: (context, state) {
              final bool isLoading = state.status == AuthStatus.loading;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.verticalSpace,

                      const AuthHeader(
                        title: AppStrings.loginTitle,
                        subtitle: AppStrings.loginSubtitle,
                      ),

                      28.verticalSpace,

                      // Email Field
                      const FieldLabel(AppStrings.emailLabel),
                      CustomTextField(
                        hintText: AppStrings.emailHint,
                        controller: _emailController,
                        validator: Validators.validateEmail,
                        prefixImage: AppImages.iconEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        radius: 16,
                      ),

                      16.verticalSpace,

                      // Password Field
                      const FieldLabel(AppStrings.passwordLabel),
                      CustomTextField(
                        hintText: AppStrings.passwordHint,
                        controller: _passwordController,
                        validator: Validators.validatePassword,
                        prefixImage: AppImages.iconPassword,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        radius: 16,
                      ),

                      12.verticalSpace,

                      // Remember Me + Forgot Password Row
                      Row(
                        children: [
                          CustomCheckboxTile(
                            value: state.rememberMe,
                            onChanged: (v) {
                              context.read<AuthCubit>().toggleRememberMe(v);
                            },
                            title: AppStrings.rememberMe,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Forgot password navigation
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: Text(
                                AppStrings.forgotPassword,
                                style: AppTextStyles.bold14TextPrimary.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      32.verticalSpace,

                      // Login Button
                      AuthButton(
                        text: AppStrings.loginButton,
                        icon: Icons.login_rounded,
                        isLoading: isLoading,
                        onPressed: () => _onLogin(context),
                      ),

                      20.verticalSpace,

                      // Footer Link (Create Account)
                      AuthFooterLink(
                        prompt: AppStrings.dontHaveAccount,
                        linkText: AppStrings.createAccount,
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.register,
                        ),
                      ),

                      24.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
