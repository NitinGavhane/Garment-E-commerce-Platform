import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/product_grid_section.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../widgets/top_bar.dart';
import '../widgets/gender_filter_tabs.dart';
import '../widgets/category_chips.dart';
import '../widgets/hero_banner.dart';
import '../widgets/brand_strip.dart';
import '../widgets/promo_grid.dart';
import '../../cart/screens/cart_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../product/screens/product_list_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import '../../profile/screens/address_list_screen.dart';
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
    final categoryProvider = context.watch<CategoryProvider>();
    final categories = categoryProvider.filteredCategories;
    final products = context.watch<ProductProvider>().featuredProducts;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              cartCount: cartCount,
              onSearchTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              onWishlistTap: () {
                final auth = context.read<AuthProvider>();
                if (!auth.isLoggedIn) {
                  Navigator.pushNamed(context, '/login');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WishlistScreen()),
                  );
                }
              },
              onCartTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              onNotificationTap: () {},
              onProfileTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
              onAddressTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddressListScreen(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GenderFilterTabs(
                      selectedGender: categoryProvider.selectedGender,
                      onTabChanged: (tab) =>
                          context.read<CategoryProvider>().setGender(tab),
                    ),
                    CategoryChips(
                      categories: categories,
                      onCategoryTap: (cat) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(category: cat),
                        ),
                      ),
                    ),
                    const HeroBanner(),
                    const BrandStrip(),
                    const PromoGrid(
                      onBrandDayTap: null,
                      onStylishStealsTap: null,
                    ),
                    ProductGridSection(
                      title: 'Featured Products',
                      subtitle: 'Handpicked just for you',
                      products: products,
                      onViewAll: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(title: 'Featured'),
                        ),
                      ),
                    ),
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
