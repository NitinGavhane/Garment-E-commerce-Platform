import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forgot Password', style: AppTextStyles.headline1),
              const SizedBox(height: AppDimensions.sm),
              Text(
                _sent
                    ? 'Password reset link has been sent to your email'
                    : 'Enter your email and we\'ll send you a reset link',
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: AppDimensions.xxl),
              if (!_sent) ...[
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Iconsax.sms, size: 20),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Please enter email' : null,
                ),
                const SizedBox(height: AppDimensions.lg),
                AppButton(
                  label: 'Send Reset Link',
                  onPressed: () {
                    setState(() => _sent = true);
                  },
                ),
              ] else ...[
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: AppColors.success, size: 40),
                ),
                const SizedBox(height: AppDimensions.lg),
                AppButton(
                  label: 'Back to Login',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
