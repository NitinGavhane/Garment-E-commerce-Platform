import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../mock/mock_data.dart';
import '../../../models/address.dart';
import '../../../models/order.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Address? _selectedAddress;
  String _selectedPayment = 'Google Pay';

  @override
  void initState() {
    super.initState();
    _selectedAddress = MockData.addresses.firstWhere(
      (a) => a.isDefault,
      orElse: () => MockData.addresses.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = MockData.cartItems.fold<double>(
        0, (sum, item) => sum + item.totalPrice);
    final shipping = subtotal > 100 ? 0.0 : 9.99;
    final total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: AppTextStyles.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.md),
        children: [
          _sectionHeader('Delivery Address', Iconsax.location),
          const SizedBox(height: AppDimensions.sm),
          if (_selectedAddress != null)
            GestureDetector(
              onTap: () => _showAddressPicker(context),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Iconsax.home,
                          color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_selectedAddress!.fullName} • ${_selectedAddress!.type}',
                            style: AppTextStyles.subtitle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_selectedAddress!.street}, ${_selectedAddress!.city}, ${_selectedAddress!.state} - ${_selectedAddress!.pincode}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textHint, size: 20),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppDimensions.lg),
          _sectionHeader('Payment Method', Iconsax.wallet),
          const SizedBox(height: AppDimensions.sm),
          ...MockData.paymentMethods.map((pm) => _PaymentMethodTile(
                name: pm['name'] as String,
                icon: pm['icon'] as IconData,
                isPopular: pm['isPopular'] as bool,
                isSelected: _selectedPayment == pm['name'],
                onTap: () => setState(() => _selectedPayment = pm['name'] as String),
              )),
          const SizedBox(height: AppDimensions.lg),
          _sectionHeader('Order Summary', Iconsax.receipt),
          const SizedBox(height: AppDimensions.sm),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: Column(
              children: [
                ...MockData.cartItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: item.product.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.checkroom_rounded,
                                size: 22,
                                color: AppColors.white.withValues(alpha: 0.5)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product.title,
                                    style: AppTextStyles.bodySmall
                                        .copyWith(fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                  'Qty: ${item.quantity} • ${item.selectedSize} • ${item.selectedColor}',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                          Text('₹${item.totalPrice.toStringAsFixed(2)}',
                              style: AppTextStyles.priceSmall),
                        ],
                      ),
                    )),
                const Divider(),
                _summaryRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
                _summaryRow('Shipping',
                    shipping == 0 ? 'FREE' : '₹${shipping.toStringAsFixed(2)}'),
                const Divider(),
                _summaryRow('Total', '₹${total.toStringAsFixed(2)}',
                    isTotal: true),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.xl),
          if (MockData.currentLoggedInUser == null)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Iconsax.info_circle,
                          color: AppColors.warning, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Please sign in to place your order',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.md),
                AppButton(
                  label: 'Sign In to Continue',
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                ),
              ],
            )
          else
            AppButton(
              label: 'Place Order • \$${total.toStringAsFixed(2)}',
              onPressed: () => _showOrderPlaced(context),
            ),
          const SizedBox(height: AppDimensions.lg),
        ],
      ),
    );
  }

  void _showAddressPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(AppDimensions.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Address', style: AppTextStyles.title),
            const SizedBox(height: AppDimensions.md),
            ...MockData.addresses
                .map((a) => RadioListTile<Address>(
                      value: a,
                      groupValue: _selectedAddress,
                      onChanged: (v) {
                        setState(() => _selectedAddress = v!);
                        Navigator.pop(ctx);
                      },
                      title: Text('${a.fullName} • ${a.type}',
                          style: AppTextStyles.subtitle),
                      subtitle: Text(
                          '${a.street}, ${a.city} - ${a.pincode}',
                          style: AppTextStyles.caption),
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ))
                ,
            const SizedBox(height: AppDimensions.md),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(ctx),
              icon: const Icon(Iconsax.add, size: 18),
              label: const Text('Add New Address'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createOrder() {
    final orderId = 'ord${MockData.orders.length + 5}';
    final orderNum = 'ORD-2026-${(100 + MockData.orders.length + 1).toString().padLeft(3, '0')}';
    final items = MockData.cartItems.map((ci) => OrderItem(
      id: 'oi_${ci.id}',
      product: ci.product,
      quantity: ci.quantity,
      price: ci.product.price,
      size: ci.selectedSize,
      color: ci.selectedColor,
    )).toList();
    final subtotal = items.fold<double>(0, (s, i) => s + i.price * i.quantity);
    final shipping = subtotal > 100 ? 0.0 : 9.99;
    final total = subtotal + shipping;

    MockData.orders.insert(0, Order(
      id: orderId,
      orderNumber: orderNum,
      items: items,
      subtotal: subtotal,
      shipping: shipping,
      discount: 0,
      gst: total * 0.12,
      total: total + total * 0.12,
      status: OrderStatus.placed,
      address: _selectedAddress ?? MockData.addresses.first,
      paymentMethod: _selectedPayment,
      createdAt: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 5)),
      trackingId: 'TRK${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
    ));
    MockData.cartItems.clear();
  }

  void _showOrderPlaced(BuildContext context) {
    _createOrder();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppDimensions.lg),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check,
                    color: AppColors.success, size: 28),
              ),
              const SizedBox(height: AppDimensions.md),
              Text(
                'Order Placed Successfully!',
                style: AppTextStyles.headline3,
              ),
              const SizedBox(height: AppDimensions.sm),
              Text(
                'Your order will be delivered by ${DateTime.now().add(const Duration(days: 5)).toString().split(' ')[0]}',
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.xl),
              AppButton(
                label: 'Track Order',
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pushReplacementNamed(context, '/main');
                },
              ),
              const SizedBox(height: AppDimensions.sm),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pushReplacementNamed(context, '/main');
                },
                child: Text(
                  'Continue Shopping',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textPrimary),
        const SizedBox(width: 8),
        Text(title, style: AppTextStyles.subtitle),
      ],
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTextStyles.title
                : AppTextStyles.bodySmall,
          ),
          Text(
            value,
            style: isTotal
                ? AppTextStyles.headline3.copyWith(
                    color: AppColors.secondary, fontSize: 18)
                : AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isPopular;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.name,
    required this.icon,
    required this.isPopular,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24,
                color: isSelected ? AppColors.primary : AppColors.textHint),
            const SizedBox(width: 12),
            Expanded(
              child: Text(name, style: AppTextStyles.body),
            ),
            if (isPopular)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Popular',
                    style: AppTextStyles.caption.copyWith(
                        color: AppColors.success, fontSize: 9)),
              ),
            const SizedBox(width: 8),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}
