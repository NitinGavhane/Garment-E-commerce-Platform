import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/orders/screens/order_list_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/wishlist/screens/wishlist_screen.dart';
import '../mock/mock_data.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      case orders:
        return MaterialPageRoute(
          builder: (_) => const OrderListScreen(),
        );
      case wishlist:
        return MaterialPageRoute(
          builder: (_) => const WishlistScreen(),
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
        );
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

  final _screens = const [
    HomeScreen(),
    CartScreen(),
    OrderListScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = MockData.cartItems.length;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: cartCount > 0
                ? Badge(
                    label: Text('$cartCount', style: const TextStyle(fontSize: 9)),
                    child: const Icon(Icons.shopping_bag_outlined),
                  )
                : const Icon(Icons.shopping_bag_outlined),
            activeIcon: cartCount > 0
                ? Badge(
                    label: Text('$cartCount', style: const TextStyle(fontSize: 9)),
                    child: const Icon(Icons.shopping_bag),
                  )
                : const Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
