import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../mock/mock_data.dart';
import '../../orders/screens/order_list_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import 'wallet_screen.dart';
import 'referral_screen.dart';
import 'reviews_screen.dart';
import 'address_list_screen.dart';
import 'notification_screen.dart';
import 'help_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentLoggedInUser;

    if (user == null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.divider,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Iconsax.user,
                        size: 40, color: AppColors.textHint),
                  ),
                  const SizedBox(height: AppDimensions.lg),
                  Text(
                    'Sign in to your account',
                    style: AppTextStyles.headline3,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  Text(
                    'Access your orders, wishlist & more',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppDimensions.xxl),
                  AppButton(
                    label: 'Sign In',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.sm),
              Stack(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user.fullName.split(' ').map((n) => n[0]).join(),
                        style: AppTextStyles.headline1.copyWith(
                          color: AppColors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.surface, width: 2),
                      ),
                      child: const Icon(Icons.edit,
                          size: 14, color: AppColors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.md),
              Text(
                user.fullName,
                style: AppTextStyles.headline3,
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppDimensions.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _statBadge('Orders', '${MockData.orders.length}'),
                  const SizedBox(width: AppDimensions.lg),
                  _statBadge('Wishlist', '${MockData.wishlistCount}'),
                  const SizedBox(width: AppDimensions.lg),
                  _statBadge('Wallet', '₹${user.walletBalance.toStringAsFixed(0)}'),
                ],
              ),
              const SizedBox(height: AppDimensions.xxl),
              ...MockData.profileOptions.map((opt) => ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        opt['icon'] as IconData,
                        size: 20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    title: Text(
                      opt['title'] as String,
                      style: AppTextStyles.body,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if ((opt['count'] as String).isNotEmpty)
                          Text(
                            opt['count'] as String,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right,
                            color: AppColors.textHint, size: 20),
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 2),
                    onTap: () {
                      final title = opt['title'] as String;
                      Widget screen;
                      switch (title) {
                        case 'My Orders':
                          screen = const OrderListScreen();
                          break;
                        case 'My Wishlist':
                          screen = const WishlistScreen();
                          break;
                        case 'My Wallet':
                          screen = const WalletScreen();
                          break;
                        case 'My Referrals':
                          screen = const ReferralScreen();
                          break;
                        case 'My Reviews':
                          screen = const ReviewsScreen();
                          break;
                        case 'My Addresses':
                          screen = const AddressListScreen();
                          break;
                        case 'Notification':
                          screen = const NotificationScreen();
                          break;
                        case 'Help & Support':
                          screen = const HelpScreen();
                          break;
                        case 'Settings':
                          screen = const SettingsScreen();
                          break;
                        default:
                          return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => screen),
                      );
                    },
                  )),
              const SizedBox(height: AppDimensions.lg),
              AppButton(
                label: 'Sign Out',
                onPressed: () {
                  MockData.currentLoggedInUser = null;
                  MockData.cartItems.clear();
                  Navigator.pushReplacementNamed(context, '/main');
                },
                isOutline: true,
                color: AppColors.error,
                textColor: AppColors.error,
              ),
              const SizedBox(height: AppDimensions.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBadge(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.headline2.copyWith(
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
