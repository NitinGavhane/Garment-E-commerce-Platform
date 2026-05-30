import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../mock/mock_data.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static final List<Map<String, dynamic>> _transactions = [
    {'title': 'Order Refund', 'amount': '+ ₹49.99', 'date': 'May 25, 2026', 'type': 'credit'},
    {'title': 'Wallet Top-up', 'amount': '+ ₹200.00', 'date': 'May 20, 2026', 'type': 'credit'},
    {'title': 'Order Payment', 'amount': '- ₹102.63', 'date': 'May 24, 2026', 'type': 'debit'},
    {'title': 'Referral Bonus', 'amount': '+ ₹50.00', 'date': 'May 15, 2026', 'type': 'credit'},
  ];

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentLoggedInUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet', style: AppTextStyles.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.md),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wallet Balance', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                  const SizedBox(height: 8),
                  Text('₹${user.walletBalance.toStringAsFixed(2)}',
                      style: AppTextStyles.displayLarge.copyWith(color: AppColors.white)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _walletButton(Iconsax.add, 'Add Money'),
                      const SizedBox(width: 12),
                      _walletButton(Iconsax.send_sqaure_2, 'Send'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: AppTextStyles.subtitle),
                TextButton(
                  onPressed: () {},
                  child: Text('See All', style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary)),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.sm),
            ..._transactions.map((t) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: t['type'] == 'credit'
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      t['type'] == 'credit' ? Iconsax.arrow_down : Iconsax.arrow_up,
                      size: 20,
                      color: t['type'] == 'credit' ? AppColors.success : AppColors.error,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t['title'] as String, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                        Text(t['date'] as String, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  Text(t['amount'] as String, style: AppTextStyles.priceSmall.copyWith(
                    color: t['type'] == 'credit' ? AppColors.success : AppColors.error,
                  )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _walletButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        side: BorderSide(color: AppColors.white.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
