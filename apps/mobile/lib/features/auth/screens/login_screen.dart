import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../mock/mock_data.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim().toLowerCase();
      final password = _passwordController.text;

      final creds = MockData.credentials[email];
      if (creds == null || creds['password'] != password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
        return;
      }

      MockData.currentLoggedInUser = MockData.currentUser;

      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.xl),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  ),
                  child: const Icon(
                    Icons.checkroom_rounded,
                    color: AppColors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: AppDimensions.lg),
                Text(
                  'Welcome back',
                  style: AppTextStyles.headline1,
                ),
                const SizedBox(height: AppDimensions.sm),
                Text(
                  'Sign in to your account',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: AppDimensions.xxl),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email (e.g. priya.sharma@email.com)',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Iconsax.sms, size: 20),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Please enter email' : null,
                ),
                const SizedBox(height: AppDimensions.md),
                AppTextField(
                  controller: _passwordController,
                  hintText: 'Password (e.g. user123)',
                  isPassword: true,
                  obscure: _obscurePassword,
                  onTogglePassword: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  prefixIcon: const Icon(Iconsax.lock, size: 20),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Please enter password' : null,
                ),
                const SizedBox(height: AppDimensions.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.md),
                AppButton(
                  label: 'Sign In',
                  onPressed: _login,
                ),
                const SizedBox(height: AppDimensions.lg),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.md),
                      child: Text(
                        'or continue with',
                        style: AppTextStyles.caption,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: AppDimensions.lg),
                Row(
                  children: [
                    Expanded(
                      child: _socialButton(
                        icon: Icons.g_mobiledata,
                        label: 'Google',
                      ),
                    ),
                    const SizedBox(width: AppDimensions.md),
                    Expanded(
                      child: _socialButton(
                        icon: Icons.phone_android,
                        label: 'OTP',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.xxl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: _goToRegister,
                      child: Text(
                        'Sign Up',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({required IconData icon, required String label}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}