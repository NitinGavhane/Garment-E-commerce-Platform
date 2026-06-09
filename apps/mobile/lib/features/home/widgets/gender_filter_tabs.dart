import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class GenderFilterTabs extends StatefulWidget {
  final ValueChanged<String>? onTabChanged;

  const GenderFilterTabs({super.key, this.onTabChanged});

  @override
  State<GenderFilterTabs> createState() => _GenderFilterTabsState();
}

class _GenderFilterTabsState extends State<GenderFilterTabs> {
  int _selectedIndex = 0;

  final _tabs = ['ALL', 'MEN', 'WOMEN', 'KIDS'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                final isActive = _selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    widget.onTabChanged?.call(_tabs[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _tabs[index],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                            color: isActive ? AppColors.brandDark : AppColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 3,
                          width: 20,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(Icons.grid_view_rounded, size: 20, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
