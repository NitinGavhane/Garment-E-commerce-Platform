import 'package:flutter/material.dart';
import '../models/product.dart';
import '../features/orders/models/order_return_replace_request.dart';
import '../models/category.dart';
import '../models/user.dart';
import '../models/address.dart';
import '../models/order.dart';
import '../models/cart_item.dart';
import '../core/constants/app_colors.dart';

class MockData {
  static List<Category> categories = [
    const Category(
      id: 'cat1',
      name: 'Men',
      icon: Icons.man,
      color: AppColors.categoryMen,
      productCount: 24,
    ),
    const Category(
      id: 'cat2',
      name: 'Women',
      icon: Icons.woman,
      color: AppColors.categoryWomen,
      productCount: 32,
    ),
    const Category(
      id: 'cat3',
      name: 'Kids',
      icon: Icons.child_care,
      color: AppColors.categoryKids,
      productCount: 18,
    ),
    const Category(
      id: 'cat4',
      name: 'Accessories',
      icon: Icons.watch,
      color: AppColors.categoryAccessories,
      productCount: 15,
    ),
    const Category(
      id: 'cat5',
      name: 'Footwear',
      icon: Icons.directions_run,
      color: Color(0xFF8B5CF6),
      productCount: 20,
    ),
    const Category(
      id: 'cat6',
      name: 'Ethnic',
      icon: Icons.diamond,
      color: Color(0xFFEC4899),
      productCount: 14,
    ),
    const Category(
      id: 'cat7',
      name: 'Western',
      icon: Icons.checkroom,
      color: Color(0xFF14B8A6),
      productCount: 22,
    ),
    const Category(
      id: 'cat8',
      name: 'Sports',
      icon: Icons.fitness_center,
      color: Color(0xFFF97316),
      productCount: 16,
    ),
  ];

  static List<Product> products = [
    const Product(
      id: 'p1',
      title: 'Premium Cotton T-Shirt',
      description: 'High-quality 100% organic cotton t-shirt with a relaxed fit.',
      brand: 'Urban Threads',
      category: 'Men',
      categoryId: 'cat1',
      price: 29.99,
      originalPrice: 49.99,
      discountPercentage: 40,
      rating: 4.5,
      reviewCount: 128,
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Black', 'White', 'Navy', 'Gray'],
      isFeatured: true,
      isNew: false,
      badge: 'Best Seller',
      stock: 150,
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
    ),
    const Product(
      id: 'p2',
      title: 'Slim Fit Blazer',
      description: 'Modern slim fit blazer crafted from premium wool blend.',
      brand: 'Sartorial Edge',
      category: 'Men',
      categoryId: 'cat1',
      price: 149.99,
      originalPrice: 249.99,
      discountPercentage: 40,
      rating: 4.7,
      reviewCount: 89,
      sizes: ['M', 'L', 'XL'],
      colors: ['Charcoal', 'Navy', 'Black'],
      isFeatured: true,
      isNew: true,
      badge: 'New',
      stock: 45,
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
    ),
    const Product(
      id: 'p3',
      title: 'Floral Summer Dress',
      description: 'Beautiful floral print dress with a flattering A-line silhouette.',
      brand: 'Bloom & Co',
      category: 'Women',
      categoryId: 'cat2',
      price: 59.99,
      originalPrice: 89.99,
      discountPercentage: 33,
      rating: 4.6,
      reviewCount: 215,
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      colors: ['Blue Floral', 'Pink Floral', 'Yellow Floral'],
      isFeatured: true,
      isNew: false,
      badge: 'Popular',
      stock: 80,
      imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400',
    ),
    const Product(
      id: 'p4',
      title: 'Designer Handbag',
      description: 'Luxury handbag crafted from genuine leather with gold-toned hardware.',
      brand: 'Luxe Carry',
      category: 'Accessories',
      categoryId: 'cat4',
      price: 199.99,
      originalPrice: 349.99,
      discountPercentage: 43,
      rating: 4.8,
      reviewCount: 156,
      sizes: ['One Size'],
      colors: ['Tan', 'Black', 'Burgundy'],
      isFeatured: true,
      isNew: false,
      badge: 'Hot Deal',
      stock: 25,
      imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400',
    ),
    const Product(
      id: 'p5',
      title: 'Denim Jacket',
      description: 'Classic denim jacket with a modern twist. Features distressed details.',
      brand: 'Rebel Denim',
      category: 'Men',
      categoryId: 'cat1',
      price: 79.99,
      originalPrice: 119.99,
      discountPercentage: 33,
      rating: 4.4,
      reviewCount: 94,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Light Wash', 'Dark Wash', 'Black'],
      isFeatured: false,
      isNew: true,
      badge: 'New',
      stock: 60,
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400',
    ),
    const Product(
      id: 'p6',
      title: 'Yoga Leggings',
      description: 'High-waist compression leggings with moisture-wicking technology.',
      brand: 'Flex Fit',
      category: 'Women',
      categoryId: 'cat2',
      price: 44.99,
      originalPrice: 69.99,
      discountPercentage: 36,
      rating: 4.7,
      reviewCount: 312,
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Burgundy', 'Teal'],
      isFeatured: true,
      isNew: false,
      badge: 'Best Seller',
      stock: 200,
      imageUrl: 'https://images.unsplash.com/photo-1506629082955-511b1aa562c8?w=400',
    ),
    const Product(
      id: 'p7',
      title: 'Kids Animal T-Shirt',
      description: 'Fun animal print t-shirt for kids. Made from soft, hypoallergenic cotton.',
      brand: 'Tiny Tots',
      category: 'Kids',
      categoryId: 'cat3',
      price: 14.99,
      originalPrice: 24.99,
      discountPercentage: 40,
      rating: 4.3,
      reviewCount: 67,
      sizes: ['2-3Y', '3-4Y', '5-6Y', '7-8Y'],
      colors: ['Blue', 'Pink', 'Green'],
      isFeatured: false,
      isNew: false,
      badge: 'Sale',
      stock: 120,
      imageUrl: 'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?w=400',
    ),
    const Product(
      id: 'p8',
      title: 'Leather Sneakers',
      description: 'Premium leather sneakers with cushioned sole for all-day comfort.',
      brand: 'Sole Society',
      category: 'Footwear',
      categoryId: 'cat5',
      price: 89.99,
      originalPrice: 149.99,
      discountPercentage: 40,
      rating: 4.6,
      reviewCount: 178,
      sizes: ['7', '8', '9', '10', '11', '12'],
      colors: ['White', 'Black', 'Tan'],
      isFeatured: true,
      isNew: false,
      badge: 'Trending',
      stock: 90,
      imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
    ),
    const Product(
      id: 'p9',
      title: 'Silk Evening Gown',
      description: 'Elegant floor-length evening gown in pure silk with delicate embroidery.',
      brand: 'Velvet Rose',
      category: 'Women',
      categoryId: 'cat2',
      price: 299.99,
      originalPrice: 499.99,
      discountPercentage: 40,
      rating: 4.9,
      reviewCount: 42,
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['Midnight Blue', 'Burgundy', 'Emerald'],
      isFeatured: true,
      isNew: true,
      badge: 'Premium',
      stock: 15,
      imageUrl: 'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=400',
    ),
    const Product(
      id: 'p10',
      title: 'Cashmere Sweater',
      description: 'Luxuriously soft cashmere sweater with ribbed cuffs and hem.',
      brand: 'Nordic Knit',
      category: 'Men',
      categoryId: 'cat1',
      price: 129.99,
      originalPrice: 189.99,
      discountPercentage: 32,
      rating: 4.5,
      reviewCount: 73,
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Gray', 'Navy', 'Burgundy', 'Forest Green'],
      isFeatured: false,
      isNew: false,
      badge: 'Warm Pick',
      stock: 35,
      imageUrl: 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=400',
    ),
    const Product(
      id: 'p11',
      title: 'Kids Raincoat Set',
      description: 'Waterproof raincoat with matching boots. Features fun dinosaur print.',
      brand: 'Rainbow Kids',
      category: 'Kids',
      categoryId: 'cat3',
      price: 39.99,
      originalPrice: 59.99,
      discountPercentage: 33,
      rating: 4.4,
      reviewCount: 55,
      sizes: ['2-3Y', '3-4Y', '5-6Y'],
      colors: ['Yellow', 'Red', 'Blue'],
      isFeatured: false,
      isNew: true,
      badge: 'New',
      stock: 40,
      imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=400',
    ),
    const Product(
      id: 'p12',
      title: 'Gold Hoop Earrings',
      description: 'Stunning 18K gold-plated hoop earrings with a polished finish.',
      brand: 'Gleam & Glow',
      category: 'Accessories',
      categoryId: 'cat4',
      price: 49.99,
      originalPrice: 89.99,
      discountPercentage: 44,
      rating: 4.7,
      reviewCount: 203,
      sizes: ['Small', 'Medium', 'Large'],
      colors: ['Gold', 'Silver', 'Rose Gold'],
      isFeatured: true,
      isNew: false,
      badge: 'Best Seller',
      stock: 150,
      imageUrl: 'https://images.unsplash.com/photo-1635767798638-3e25273a8236?w=400',
    ),
    const Product(
      id: 'p13',
      title: 'Running Shoes',
      description: 'Lightweight running shoes with responsive cushioning and breathable mesh.',
      brand: 'Stride X',
      category: 'Footwear',
      categoryId: 'cat5',
      price: 119.99,
      originalPrice: 179.99,
      discountPercentage: 33,
      rating: 4.6,
      reviewCount: 245,
      sizes: ['7', '8', '9', '10', '11', '12', '13'],
      colors: ['Black/White', 'Blue/Neon', 'Red/Black'],
      isFeatured: true,
      isNew: false,
      badge: 'Performance',
      stock: 75,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    ),
    const Product(
      id: 'p14',
      title: 'Embroidered Kurta Set',
      description: 'Traditional embroidered kurta with churidar and dupatta set.',
      brand: 'Ethnic Elegance',
      category: 'Women',
      categoryId: 'cat2',
      price: 89.99,
      originalPrice: 149.99,
      discountPercentage: 40,
      rating: 4.8,
      reviewCount: 167,
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Pink', 'Green', 'Blue', 'Yellow'],
      isFeatured: true,
      isNew: false,
      badge: 'Festival Special',
      stock: 55,
      imageUrl: 'https://images.unsplash.com/photo-1583391733956-6c78276477e3?w=400',
    ),
    const Product(
      id: 'p15',
      title: 'Woolen Scarf',
      description: 'Handwoven woolen scarf with traditional patterns.',
      brand: 'Cozy Crafts',
      category: 'Accessories',
      categoryId: 'cat4',
      price: 34.99,
      originalPrice: 54.99,
      discountPercentage: 36,
      rating: 4.3,
      reviewCount: 88,
      sizes: ['One Size'],
      colors: ['Red', 'Gray', 'Navy', 'Mustard'],
      isFeatured: false,
      isNew: false,
      badge: 'Winter Wear',
      stock: 100,
      imageUrl: 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=400',
    ),
    const Product(
      id: 'p16',
      title: 'Cargo Joggers',
      description: 'Comfortable cargo joggers with multiple pockets. Made from stretch cotton.',
      brand: 'Street Vibe',
      category: 'Men',
      categoryId: 'cat1',
      price: 49.99,
      originalPrice: 79.99,
      discountPercentage: 38,
      rating: 4.4,
      reviewCount: 134,
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Black', 'Olive', 'Gray', 'Navy'],
      isFeatured: false,
      isNew: true,
      badge: 'Trending',
      stock: 110,
      imageUrl: 'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=400',
    ),
  ];

  static List<Product> get featuredProducts =>
      products.where((p) => p.isFeatured).toList();

  static List<Product> get newProducts =>
      products.where((p) => p.isNew).toList();

  static List<Product> getProductsByCategory(String categoryId) =>
      products.where((p) => p.categoryId == categoryId).toList();

  static List<Product> searchProducts(String query) {
    final q = query.toLowerCase();
    return products
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.brand.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
  }

  static const User currentUser = User(
    id: 'u1',
    fullName: 'Priya Sharma',
    email: 'priya.sharma@email.com',
    phone: '+91 98765 43210',
    walletBalance: 250.00,
    referralCode: 'PRIYA250',
    isVerified: true,
    role: UserRole.user,
  );

  static User? currentLoggedInUser;

  static const Map<String, Map<String, String>> credentials = {
    'priya.sharma@email.com': {
      'password': 'user123',
      'role': 'user',
    },
    'user@test.com': {
      'password': 'user123',
      'role': 'user',
    },
  };

  static List<Address> addresses = [
    const Address(
      id: 'addr1',
      fullName: 'Priya Sharma',
      phone: '+91 98765 43210',
      street: '42, MG Road, Indiranagar',
      city: 'Bengaluru',
      state: 'Karnataka',
      pincode: '560038',
      isDefault: true,
      type: 'Home',
    ),
    const Address(
      id: 'addr2',
      fullName: 'Priya Sharma',
      phone: '+91 98765 43210',
      street: 'Suite 501, Tech Park, Whitefield',
      city: 'Bengaluru',
      state: 'Karnataka',
      pincode: '560066',
      isDefault: false,
      type: 'Work',
    ),
  ];

  static List<CartItem> cartItems = [
    CartItem(
      id: 'ci1',
      product: products[0],
      quantity: 2,
      selectedSize: 'M',
      selectedColor: 'Black',
    ),
    CartItem(
      id: 'ci2',
      product: products[5],
      quantity: 1,
      selectedSize: 'S',
      selectedColor: 'Black',
    ),
    CartItem(
      id: 'ci3',
      product: products[11],
      quantity: 1,
      selectedSize: 'Small',
      selectedColor: 'Gold',
    ),
  ];

  static int _cartIdCounter = 4;

  static void addToCart(Product product,
      {required int quantity,
      required String selectedSize,
      required String selectedColor}) {
    final existingIndex = cartItems.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == selectedSize &&
          item.selectedColor == selectedColor,
    );
    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity += quantity;
    } else {
      cartItems.add(CartItem(
        id: 'ci${_cartIdCounter++}',
        product: product,
        quantity: quantity,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
      ));
    }
  }

  static List<Order> orders = [
    Order(
      id: 'ord1',
      orderNumber: 'ORD-2026-001',
      items: [
        OrderItem(
          id: 'oi1',
          product: products[0],
          quantity: 2,
          price: 29.99,
          size: 'M',
          color: 'Black',
        ),
        OrderItem(
          id: 'oi2',
          product: products[5],
          quantity: 1,
          price: 44.99,
          size: 'S',
          color: 'Navy',
        ),
      ],
      subtotal: 104.97,
      shipping: 0,
      discount: 15.75,
      gst: 13.41,
      total: 102.63,
      status: OrderStatus.outForDelivery,
      address: addresses[0],
      paymentMethod: 'UPI (Google Pay)',
      createdAt: DateTime(2026, 5, 24),
      estimatedDelivery: DateTime(2026, 5, 28),
      trackingId: 'TRK12847003',
    ),
    Order(
      id: 'ord2',
      orderNumber: 'ORD-2026-002',
      items: [
        OrderItem(
          id: 'oi3',
          product: products[3],
          quantity: 1,
          price: 199.99,
          size: 'One Size',
          color: 'Tan',
        ),
      ],
      subtotal: 199.99,
      shipping: 0,
      discount: 0,
      gst: 25.99,
      total: 225.98,
      status: OrderStatus.processing,
      address: addresses[1],
      paymentMethod: 'Credit Card',
      createdAt: DateTime(2026, 5, 25),
      estimatedDelivery: DateTime(2026, 5, 30),
    ),
    Order(
      id: 'ord3',
      orderNumber: 'ORD-2026-003',
      items: [
        OrderItem(
          id: 'oi4',
          product: products[8],
          quantity: 1,
          price: 299.99,
          size: 'M',
          color: 'Midnight Blue',
        ),
        OrderItem(
          id: 'oi5',
          product: products[11],
          quantity: 1,
          price: 49.99,
          size: 'Medium',
          color: 'Gold',
        ),
      ],
      subtotal: 349.98,
      shipping: 0,
      discount: 50.00,
      gst: 38.99,
      total: 338.97,
      status: OrderStatus.delivered,
      address: addresses[0],
      paymentMethod: 'Cash on Delivery',
      createdAt: DateTime(2026, 5, 20),
      estimatedDelivery: DateTime(2026, 5, 25),
      returnReplaceRequests: [
        OrderReturnReplaceRequest(
          id: 'rr1',
          type: ReturnReplaceType.returnRequest,
          status: ReturnReplaceStatus.submitted,
          items: [
            const OrderReturnReplaceRequestItem(
              orderItemId: 'oi4',
              quantity: 1,
            ),
          ],
          reason: 'Item arrived damaged',
          createdAt: DateTime(2026, 5, 26),
        ),
      ],
    ),
    Order(
      id: 'ord4',
      orderNumber: 'ORD-2026-004',
      items: [
        OrderItem(
          id: 'oi6',
          product: products[13],
          quantity: 2,
          price: 89.99,
          size: 'M',
          color: 'Pink',
        ),
      ],
      subtotal: 179.98,
      shipping: 10.00,
      discount: 25.00,
      gst: 21.45,
      total: 186.43,
      status: OrderStatus.placed,
      address: addresses[0],
      paymentMethod: 'UPI (PhonePe)',
      createdAt: DateTime(2026, 5, 26),
      estimatedDelivery: DateTime(2026, 5, 31),
      trackingId: 'TRK12847089',
    ),
  ];

  static List<String> bannerImages = [
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
    'https://images.unsplash.com/photo-1445205170230-053b83016050',
    'https://images.unsplash.com/photo-1469334031218-e382a71b716b',
  ];

  static List<Map<String, String>> banners = [
    {
      'title': 'Summer Collection',
      'subtitle': 'Up to 50% Off',
      'tag': 'Trending Now',
    },
    {
      'title': 'New Arrivals',
      'subtitle': 'Spring 2026 Styles',
      'tag': 'Fresh Drops',
    },
    {
      'title': 'Festival Edit',
      'subtitle': 'Ethnic Wear Sale',
      'tag': 'Limited Time',
    },
  ];

  static List<String> availableSizes = [
    'XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'
  ];

  static List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'Google Pay',
      'icon': Icons.g_mobiledata,
      'isPopular': true,
    },
    {
      'name': 'PhonePe',
      'icon': Icons.phone_android,
      'isPopular': true,
    },
    {
      'name': 'Paytm',
      'icon': Icons.account_balance_wallet,
      'isPopular': true,
    },
    {
      'name': 'Credit Card',
      'icon': Icons.credit_card,
      'isPopular': false,
    },
    {
      'name': 'Debit Card',
      'icon': Icons.credit_card_outlined,
      'isPopular': false,
    },
    {
      'name': 'Net Banking',
      'icon': Icons.account_balance,
      'isPopular': false,
    },
    {
      'name': 'Cash on Delivery',
      'icon': Icons.money,
      'isPopular': false,
    },
  ];

  static List<Map<String, dynamic>> profileOptions = [
    {'title': 'My Orders', 'icon': Icons.receipt_long, 'count': '4'},
    {'title': 'My Wishlist', 'icon': Icons.favorite_outline, 'count': '6'},
    {'title': 'My Wallet', 'icon': Icons.account_balance_wallet, 'count': '₹250.00'},
    {'title': 'My Referrals', 'icon': Icons.share, 'count': '3'},
    {'title': 'My Reviews', 'icon': Icons.star_outline, 'count': '12'},
    {'title': 'My Addresses', 'icon': Icons.location_on_outlined, 'count': '2'},
    {'title': 'Notification', 'icon': Icons.notifications_outlined, 'count': '3'},
    {'title': 'Help & Support', 'icon': Icons.headset_mic, 'count': ''},
    {'title': 'Settings', 'icon': Icons.settings_outlined, 'count': ''},
  ];

  static final Set<String> wishlistedIds = {'p1', 'p3', 'p8', 'p12'};

  static void toggleWishlist(String productId) {
    if (wishlistedIds.contains(productId)) {
      wishlistedIds.remove(productId);
    } else {
      wishlistedIds.add(productId);
    }
  }

  static int get wishlistCount => wishlistedIds.length;

  static List<Map<String, String>> blogPosts = [
    {
      'title': 'How to Style Your Summer Wardrobe for Maximum Comfort',
      'author': 'Shop Admin',
      'category': 'Lifestyle',
      'imageUrl': 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=600',
    },
    {
      'title': '10 Essential Accessories Every Fashionista Needs This Season',
      'author': 'Shop Admin',
      'category': 'Fashion Tips',
      'imageUrl': 'https://images.unsplash.com/photo-1490114538077-0a7f8cb49891?w=600',
    },
    {
      'title': 'Sustainable Fashion: How to Build an Eco-Friendly Closet',
      'author': 'Shop Admin',
      'category': 'Sustainability',
      'imageUrl': 'https://images.unsplash.com/photo-1479064312651-24524fb55c0e?w=600',
    },
  ];
}
