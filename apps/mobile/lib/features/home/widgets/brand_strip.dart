import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class BrandStrip extends StatelessWidget {
  const BrandStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PoweredByStrip(),
        const SizedBox(height: 1),
        _BrandPartnersStrip(),
      ],
    );
  }
}

class _PoweredByStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B00), Color(0xFFCC0000)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            'POWERED BY',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _BrandTag(label: 'Libas', showArrow: true),
                _BrandTag(label: 'Rare Rabbit', showArrow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandPartnersStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _BrandChip(label: 'MIRAGGIO'),
          const SizedBox(width: 8),
          _BrandChip(label: 'JACK&JONES'),
          const SizedBox(width: 8),
          _BrandChip(label: 'TIMEX'),
          const Spacer(),
          Text(
            '›',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandTag extends StatelessWidget {
  final String label;
  final bool showArrow;

  const _BrandTag({required this.label, this.showArrow = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          if (showArrow) ...[
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.white.withValues(alpha: 0.7)),
          ],
        ],
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  final String label;

  const _BrandChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.brandDark,
        ),
      ),
    );
  }
}
