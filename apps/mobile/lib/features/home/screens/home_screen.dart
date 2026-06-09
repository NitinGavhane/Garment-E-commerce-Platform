import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../mock/mock_data.dart';
import '../widgets/top_bar.dart';
import '../widgets/gender_filter_tabs.dart';
import '../widgets/category_icons_grid.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/brand_strip.dart';
import '../widgets/offer_strip.dart';
import '../widgets/promo_cards.dart';
import '../widgets/trending_picks.dart';
import '../widgets/brand_spotlight.dart';
import '../widgets/luxe_section.dart';
import '../widgets/footer.dart';
import '../../cart/screens/cart_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../product/screens/product_list_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import '../../profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().fetchCategories();
      context.read<ProductProvider>().fetchProducts(featured: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().count;
    final categories = context.watch<CategoryProvider>().categories;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
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
              onProfileTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GenderFilterTabs(
                      onTabChanged: (tab) {},
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    CategoryIconsRow(
                      categories: categories,
                      onCategoryTap: (cat) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(category: cat),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    BannerCarousel(banners: MockData.banners),
                    const SizedBox(height: 12),
                    const BrandStrip(),
                    const SizedBox(height: 12),
                    const OfferStrip(),
                    const SizedBox(height: 12),
                    PromoCards(
                      onBrandDayTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductListScreen(),
                        ),
                      ),
                      onStylishStealsTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductListScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 12),
                    const Divider(height: 8, color: AppColors.divider),
                    const Footer(),
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
