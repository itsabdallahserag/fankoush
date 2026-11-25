import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fankoush/core/constants/app_colors.dart';
import 'package:fankoush/core/constants/app_images.dart';
import 'package:fankoush/core/constants/app_strings.dart';
import 'package:fankoush/core/constants/validators.dart';
import 'package:fankoush/core/routing/app_routes.dart';
import 'package:fankoush/core/utils/app_snackbar.dart';
import 'package:fankoush/shared/widgets/country_picker_bottom_sheet.dart';
import 'package:fankoush/shared/widgets/custom_text_field.dart';
import 'package:fankoush/features/auth/logic/auth_cubit.dart';
import 'package:fankoush/features/auth/logic/auth_state.dart';
import 'package:fankoush/features/auth/presentation/screens/auth_widgets/auth_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const _RegisterScreenContent(),
    );
  }
}

class _RegisterScreenContent extends StatefulWidget {
  const _RegisterScreenContent();

  @override
  State<_RegisterScreenContent> createState() => _RegisterScreenContentState();
}

class _RegisterScreenContentState extends State<_RegisterScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickCountry(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();
    final selected = await CountryPickerBottomSheet.show(
      context: context,
      currentCountry: authCubit.state.selectedCountry,
    );

    if (selected != null) {
      authCubit.selectCountry(selected);
    }
  }

  void _onRegister(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      country: _countryController.text,
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
                  state.errorMessage ?? AppStrings.registerError,
                );
              }
            },
            builder: (context, state) {
              final bool isLoading = state.status == AuthStatus.loading;
              _countryController.text = state.selectedCountry;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.verticalSpace,

                      const AuthHeader(
                        title: AppStrings.registerTitle,
                        subtitle: AppStrings.registerSubtitle,
                      ),

                      24.verticalSpace,

                      // Name Field
                      const FieldLabel(AppStrings.nameLabel),
                      CustomTextField(
                        hintText: AppStrings.nameHint,
                        controller: _nameController,
                        validator: Validators.validateName,
                        prefixImage: AppImages.iconProfile,
                        textInputAction: TextInputAction.next,
                        radius: 16,
                      ),

                      16.verticalSpace,

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

                      // Country Picker Field
                      const FieldLabel(AppStrings.countryLabel),
                      CustomTextField(
                        hintText: AppStrings.countryHint,
                        controller: _countryController,
                        readOnly: true,
                        onTap: () => _pickCountry(context),
                        prefixImage: AppImages.iconCountry,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textSecondary,
                          size: 24.sp,
                        ),
                        radius: 16,
                      ),

                      16.verticalSpace,

                      // Password Field
                      const FieldLabel(AppStrings.passwordLabel),
                      CustomTextField(
                        hintText: AppStrings.createPasswordHint,
                        controller: _passwordController,
                        validator: Validators.validatePassword,
                        prefixImage: AppImages.iconPassword,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        radius: 16,
                      ),

                      16.verticalSpace,

                      // Confirm Password Field
                      const FieldLabel(AppStrings.confirmPasswordLabel),
                      CustomTextField(
                        hintText: AppStrings.confirmPasswordHint,
                        controller: _confirmPasswordController,
                        validator: (v) => Validators.validateConfirmPassword(
                          v,
                          _passwordController.text,
                        ),
                        prefixImage: AppImages.iconPassword,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        radius: 16,
                      ),

                      32.verticalSpace,

                      // Register Button
                      AuthButton(
                        text: AppStrings.registerButton,
                        icon: Icons.arrow_forward,
                        isLoading: isLoading,
                        onPressed: () => _onRegister(context),
                      ),

                      20.verticalSpace,

                      // Footer Link (Sign In)
                      AuthFooterLink(
                        prompt: AppStrings.alreadyHaveAccount,
                        linkText: AppStrings.loginButton,
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
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
