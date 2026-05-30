import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../mock/mock_data.dart';
import '../../../models/order.dart';
import '../widgets/order_card.dart';
import 'order_detail_screen.dart';
import 'order_return_replace_sheet.dart';
import '../models/order_return_replace_request.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String _selectedFilter = 'All';

  List<Order> get _orders {
    if (_selectedFilter == 'All') return MockData.orders;
    final status = _parseStatus(_selectedFilter);
    return MockData.orders.where((o) => o.status == status).toList();
  }

  void _showReturnReplaceSheet(
      BuildContext context, Order order, ReturnReplaceType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: OrderReturnReplaceSheet(order: order, type: type),
      ),
    );
  }

  OrderStatus? _parseStatus(String filter) {
    switch (filter) {
      case 'Active':
        return OrderStatus.processing;
      case 'Shipped':
        return OrderStatus.dispatched;
      case 'Delivered':
        return OrderStatus.delivered;
      case 'Cancelled':
        return OrderStatus.cancelled;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Active', 'Shipped', 'Delivered', 'Cancelled'];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: AppTextStyles.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final f = filters[index];
                final isSelected = _selectedFilter == f;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.divider,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      f,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppDimensions.sm),
          Expanded(
            child: _orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.receipt_long,
                            size: 64, color: AppColors.textHint),
                        const SizedBox(height: 16),
                        Text('No orders found',
                            style: AppTextStyles.subtitle),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppDimensions.md),
                    itemCount: _orders.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return OrderCard(
                        order: order,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OrderDetailScreen(order: order),
                          ),
                        ),
                        onReturn: order.isReturnReplaceEligible
                            ? () => _showReturnReplaceSheet(
                                context, order, ReturnReplaceType.returnRequest)
                            : null,
                        onReplace: order.isReturnReplaceEligible
                            ? () => _showReturnReplaceSheet(
                                context, order, ReturnReplaceType.replaceRequest)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
