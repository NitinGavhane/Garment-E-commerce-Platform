import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../mock/mock_data.dart';
import '../widgets/announcement_bar.dart';
import '../widgets/flone_navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/trust_badges_row.dart';
import '../widgets/new_arrival_grid.dart';
import '../widgets/blog_section.dart';
import '../widgets/flone_footer.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _wishlistVersion = 0;

  void _onWishlistChanged() {
    setState(() {
      _wishlistVersion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = MockData.cartItems.length;

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const AnnouncementBar(),
            FloneNavbar(
              cartCount: cartCount,
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              onSearchTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              onShopTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductListScreen()),
              ),
              onWishlistTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              ),
              onCartTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              onProfileTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeroSection(
                      onShopNow: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductListScreen(),
                        ),
                      ),
                    ),
                    const TrustBadgesRow(),
                    NewArrivalGrid(
                      key: ValueKey('new_arrival_$_wishlistVersion'),
                      onWishlistChanged: _onWishlistChanged,
                    ),
                    const BlogSection(),
                    const FloneFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Flone.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            _drawerItem(Icons.home_outlined, 'Home', () {
              Navigator.pop(context);
            }),
            _drawerItem(Icons.shopping_bag_outlined, 'Shop', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductListScreen()),
              );
            }),
            _drawerItem(Icons.favorite_border, 'Wishlist', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            }),
            _drawerItem(Icons.shopping_cart_outlined, 'Cart', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            }),
            _drawerItem(Icons.person_outline, 'Profile', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
    );
  }
}
