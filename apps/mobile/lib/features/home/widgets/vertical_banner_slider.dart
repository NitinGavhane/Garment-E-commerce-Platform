import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class VerticalBannerSlider extends StatefulWidget {
  final String title;
  final List<String> imageUrls;
  final double height;

  const VerticalBannerSlider({
    super.key,
    required this.title,
    required this.imageUrls,
    this.height = 170,
  });

  @override
  State<VerticalBannerSlider> createState() => _VerticalBannerSliderState();
}

class _VerticalBannerSliderState extends State<VerticalBannerSlider> {
  int _currentPage = 0;
  final _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients && widget.imageUrls.length > 1) {
        final next = (_currentPage + 1) % widget.imageUrls.length;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) return const SizedBox.shrink();
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.nykaaBlack,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: widget.height,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: widget.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        widget.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceContainerHighest,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            color: AppColors.textHint,
                            size: 48,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (widget.imageUrls.length > 1)
                  Positioned(
                    bottom: 8,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_currentPage + 1}/${widget.imageUrls.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
