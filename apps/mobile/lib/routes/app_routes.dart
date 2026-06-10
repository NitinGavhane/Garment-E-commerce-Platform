import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/home/screens/now_screen.dart';
import '../features/home/screens/luxe_screen.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/orders/screens/order_list_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/wishlist/screens/wishlist_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/product/screens/product_list_screen.dart';
import '../providers/cart_provider.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String search = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderListScreen());
      case wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainShell());
      default:
        return MaterialPageRoute(builder: (_) => const MainShell());
    }
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = [
    const HomeScreen(),
    const ProductListScreen(maxPrice: 999.0, title: 'Under 999'),
    const NowScreen(),
    const LuxeScreen(),
    const CartScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().count;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFFfff8f7),
          border: Border(
            top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              isActive: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            _NavItem(
              icon: Icons.sell_outlined,
              label: 'Under 999',
              isActive: _currentIndex == 1,
              onTap: () => setState(() => _currentIndex = 1),
            ),
            _NavItem(
              icon: Icons.bolt,
              label: 'Now',
              isActive: _currentIndex == 2,
              onTap: () => setState(() => _currentIndex = 2),
            ),
            _NavItem(
              icon: Icons.diamond_outlined,
              label: 'Luxe',
              isActive: _currentIndex == 3,
              onTap: () => setState(() => _currentIndex = 3),
            ),
            _NavItem(
              icon: Icons.shopping_cart_outlined,
              label: 'Bag',
              isActive: _currentIndex == 4,
              badgeCount: cartCount,
              onTap: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final int badgeCount;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.badgeCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: isActive
                        ? const Color(0xFFbd003b)
                        : const Color(0xFF5f5e5e),
                  ),
                  if (badgeCount > 0)
                    Positioned(
                      right: -8,
                      top: -4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xFFbd003b),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$badgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                  color: isActive
                      ? const Color(0xFFbd003b)
                      : const Color(0xFF5f5e5e),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
