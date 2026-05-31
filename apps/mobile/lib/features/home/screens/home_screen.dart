import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../mock/mock_data.dart';
import '../widgets/nykaa_top_bar.dart';
import '../widgets/nykaa_banner_carousel.dart';
import '../widgets/category_icons_grid.dart';
import '../widgets/trending_picks.dart';
import '../widgets/brand_spotlight.dart';
import '../widgets/luxe_section.dart';
import '../widgets/blog_section.dart';
import '../widgets/nykaa_footer.dart';
import '../../cart/screens/cart_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../product/screens/product_list_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCount = MockData.cartItems.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NykaaTopBar(
              cartCount: cartCount,
              onSearchTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              onWishlistTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              ),
              onCartTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              onNotificationTap: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CategoryIconsRow(
                      categories: MockData.categories,
                      onCategoryTap: (cat) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(category: cat),
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    NykaaBannerCarousel(banners: MockData.banners),
                    const Divider(height: 8, color: AppColors.divider),
                    TrendingPicks(
                      items: MockData.trendingPicks,
                      onItemTap: (item) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductListScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 8, color: AppColors.divider),
                    BrandSpotlight(
                      brands: MockData.brands,
                      onBrandTap: (brand) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(
                            title: brand['name'],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 8, color: AppColors.divider),
                    LuxeSection(
                      items: MockData.luxeItems,
                      onItemTap: (item) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductListScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 8, color: AppColors.divider),
                    const BlogSection(),
                    const NykaaFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
