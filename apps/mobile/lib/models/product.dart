import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String brand;
  final String category;
  final String categoryId;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final int discountPercentage;
  final List<String> sizes;
  final List<String> colors;
  final bool isFeatured;
  final bool isNew;
  final String badge;
  final int stock;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.brand,
    required this.category,
    required this.categoryId,
    required this.price,
    required this.originalPrice,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.discountPercentage = 0,
    this.sizes = const ['S', 'M', 'L', 'XL', 'XXL'],
    this.colors = const ['Black', 'White', 'Blue'],
    this.isFeatured = false,
    this.isNew = false,
    this.badge = '',
    this.stock = 50,
    this.imageUrl = '',
  });

  List<Color> get gradientColors {
    final idx = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final i = idx % AppColors.productGradients.length;
    final next = (i + 1) % AppColors.productGradients.length;
    return [AppColors.productGradients[i], AppColors.productGradients[next]];
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    String? brand,
    String? category,
    String? categoryId,
    double? price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    int? discountPercentage,
    List<String>? sizes,
    List<String>? colors,
    bool? isFeatured,
    bool? isNew,
    String? badge,
    int? stock,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
      badge: badge ?? this.badge,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
