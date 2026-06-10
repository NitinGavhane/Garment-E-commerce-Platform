import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class HorizontalBannerSection extends StatelessWidget {
  final String title;
  final List<String> imageUrls;
  final double imageHeight;
  final double imageWidth;

  const HorizontalBannerSection({
    super.key,
    required this.title,
    required this.imageUrls,
    this.imageHeight = 120,
    this.imageWidth = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.nykaaBlack,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: imageHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrls[index],
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: imageWidth,
                      height: imageHeight,
                      color: AppColors.surfaceContainerHigh,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
