import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../mock/mock_data.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewedProducts = MockData.products.take(4).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Reviews', style: AppTextStyles.title),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimensions.md),
        itemCount: reviewedProducts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = reviewedProducts[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52, height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: product.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.checkroom_rounded, size: 26, color: AppColors.white.withValues(alpha: 0.5)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (i) => Icon(
                          Icons.star,
                          size: 16,
                          color: i < 4 ? AppColors.rating : AppColors.border,
                        )),
                      ),
                      const SizedBox(height: 4),
                      Text('Great quality! Highly recommended.', style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('May 20, 2026', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Edit', style: TextStyle(fontSize: 12, color: AppColors.secondary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
