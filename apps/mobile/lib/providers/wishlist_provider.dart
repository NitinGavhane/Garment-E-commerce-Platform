import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WishlistProvider extends ChangeNotifier {
  Set<String> _wishlistedIds = {};
  bool _isLoaded = false;

  Set<String> get wishlistedIds => _wishlistedIds;
  int get count => _wishlistedIds.length;
  bool get isLoaded => _isLoaded;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('wishlist_ids');
    if (stored != null) {
      final list = jsonDecode(stored) as List<dynamic>;
      _wishlistedIds = list.map((e) => e as String).toSet();
    }
    _isLoaded = true;
    notifyListeners();
  }

  bool isWishlisted(String productId) {
    return _wishlistedIds.contains(productId);
  }

  Future<void> toggle(String productId) async {
    if (_wishlistedIds.contains(productId)) {
      _wishlistedIds.remove(productId);
    } else {
      _wishlistedIds.add(productId);
    }
    notifyListeners();
    await _persist();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wishlist_ids', jsonEncode(_wishlistedIds.toList()));
  }
}
