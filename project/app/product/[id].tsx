import { useEffect, useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  Image,
  TouchableOpacity,
  StyleSheet,
  Dimensions,
  ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { ArrowLeft, Heart, ShoppingBag, Check, Share2 } from 'lucide-react-native';
import { supabase } from '@/lib/supabase';
import { Product } from '@/types';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';
import { StarRating } from '@/components/StarRating';
import { useCartStore } from '@/store/cartStore';
import { useWishlistStore } from '@/store/wishlistStore';
import { Button } from '@/components/Button';

const { width: SCREEN_WIDTH } = Dimensions.get('window');

export default function ProductDetailScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { addItem, items } = useCartStore();
  const { isWishlisted, toggle } = useWishlistStore();

  const [product, setProduct] = useState<Product | null>(null);
  const [loading, setLoading] = useState(true);
  const [selectedSize, setSelectedSize] = useState<string | null>(null);
  const [selectedColor, setSelectedColor] = useState<string | null>(null);
  const [addedToCart, setAddedToCart] = useState(false);

  useEffect(() => {
    if (id) fetchProduct();
  }, [id]);

  async function fetchProduct() {
    try {
      const { data } = await supabase
        .from('products')
        .select('*, category:categories(*)')
        .eq('id', id)
        .single();
      if (data) {
        setProduct(data as Product);
        setSelectedSize(data.sizes?.[0] ?? null);
        setSelectedColor(data.colors?.[0] ?? null);
      }
    } finally {
      setLoading(false);
    }
  }

  const wishlisted = product ? isWishlisted(product.id) : false;

  function handleAddToCart() {
    if (!product || !selectedSize || !selectedColor) return;
    addItem(product, selectedSize, selectedColor);
    setAddedToCart(true);
    setTimeout(() => setAddedToCart(false), 2000);
  }

  const cartQuantity = product
    ? items.filter(
        i => i.product.id === product.id && i.selectedSize === selectedSize && i.selectedColor === selectedColor
      ).reduce((sum, i) => sum + i.quantity, 0)
    : 0;

  if (loading) {
    return (
      <SafeAreaView style={styles.container} edges={['top']}>
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={COLORS.accent} />
        </View>
      </SafeAreaView>
    );
  }

  if (!product) {
    return (
      <SafeAreaView style={styles.container} edges={['top']}>
        <View style={styles.loadingContainer}>
          <Text style={styles.notFound}>Product not found</Text>
          <Button title="Go Back" variant="outline" onPress={() => router.back()} />
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        {/* Top Bar */}
        <View style={styles.topBar}>
          <TouchableOpacity style={styles.topBarBtn} onPress={() => router.back()}>
            <ArrowLeft size={20} color={COLORS.primary} strokeWidth={1.5} />
          </TouchableOpacity>
          <View style={styles.topBarRight}>
            <TouchableOpacity style={styles.topBarBtn}>
              <Share2 size={18} color={COLORS.primary} strokeWidth={1.5} />
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.topBarBtn}
              onPress={() => product && toggle(product)}
            >
              <Heart
                size={18}
                color={wishlisted ? COLORS.error : COLORS.primary}
                fill={wishlisted ? COLORS.error : 'transparent'}
                strokeWidth={1.5}
              />
            </TouchableOpacity>
          </View>
        </View>

        {/* Product Image */}
        <View style={styles.imageContainer}>
          <Image
            source={{ uri: product.image_url }}
            style={styles.image}
            resizeMode="cover"
          />
          {product.badge && (
            <View
              style={[
                styles.badge,
                product.badge === 'Sale' && styles.badgeSale,
                product.badge === 'New' && styles.badgeNew,
              ]}
            >
              <Text style={styles.badgeText}>{product.badge}</Text>
            </View>
          )}
        </View>

        {/* Product Info */}
        <View style={styles.infoSection}>
          {product.category && (
            <Text style={styles.category}>{product.category.name}</Text>
          )}
          <Text style={styles.productName}>{product.name}</Text>

          <View style={styles.ratingRow}>
            <StarRating rating={product.rating} size={14} />
            <Text style={styles.reviewCount}>
              {product.rating.toFixed(1)} ({product.review_count} reviews)
            </Text>
          </View>

          <View style={styles.priceRow}>
            <Text style={styles.price}>${product.price.toFixed(2)}</Text>
            {product.original_price && (
              <Text style={styles.originalPrice}>${product.original_price.toFixed(2)}</Text>
            )}
          </View>

          <Text style={styles.description}>{product.description}</Text>
        </View>

        {/* Size Selector */}
        {product.sizes.length > 0 && (
          <View style={styles.selectorSection}>
            <Text style={styles.selectorLabel}>
              Size{selectedSize && <Text style={styles.selectorValue}> — {selectedSize}</Text>}
            </Text>
            <View style={styles.selectorOptions}>
              {product.sizes.map(size => (
                <TouchableOpacity
                  key={size}
                  style={[styles.sizeOption, selectedSize === size && styles.sizeOptionActive]}
                  onPress={() => setSelectedSize(size)}
                >
                  <Text style={[styles.sizeText, selectedSize === size && styles.sizeTextActive]}>
                    {size}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>
        )}

        {/* Color Selector */}
        {product.colors.length > 0 && (
          <View style={styles.selectorSection}>
            <Text style={styles.selectorLabel}>
              Color{selectedColor && <Text style={styles.selectorValue}> — {selectedColor}</Text>}
            </Text>
            <View style={styles.selectorOptions}>
              {product.colors.map(color => (
                <TouchableOpacity
                  key={color}
                  style={[styles.colorOption, selectedColor === color && styles.colorOptionActive]}
                  onPress={() => setSelectedColor(color)}
                >
                  <Text style={[styles.colorText, selectedColor === color && styles.colorTextActive]}>
                    {color}
                  </Text>
                  {selectedColor === color && (
                    <Check size={12} color={COLORS.white} strokeWidth={3} style={{ marginLeft: 4 }} />
                  )}
                </TouchableOpacity>
              ))}
            </View>
          </View>
        )}

        <View style={styles.spacer} />
      </ScrollView>

      {/* Bottom Bar */}
      <View style={styles.bottomBar}>
        <View style={styles.bottomPrice}>
          <Text style={styles.bottomPriceLabel}>Price</Text>
          <Text style={styles.bottomPriceValue}>${product.price.toFixed(2)}</Text>
        </View>
        <Button
          title={addedToCart ? 'Added!' : cartQuantity > 0 ? `Add Again (${cartQuantity})` : 'Add to Cart'}
          variant="primary"
          size="lg"
          icon={addedToCart ? <Check size={18} color={COLORS.white} strokeWidth={2.5} /> : <ShoppingBag size={18} color={COLORS.white} strokeWidth={1.5} />}
          onPress={handleAddToCart}
          disabled={!selectedSize || !selectedColor}
          style={styles.addToCartBtn}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  scroll: {
    paddingBottom: 100,
  },
  loadingContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    gap: SPACING.md,
  },
  notFound: {
    fontFamily: FONTS.serif.semiBold,
    fontSize: 20,
    color: COLORS.primary,
  },
  topBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: SPACING.lg,
    paddingVertical: SPACING.sm,
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    zIndex: 10,
  },
  topBarRight: {
    flexDirection: 'row',
    gap: SPACING.sm,
  },
  topBarBtn: {
    width: 40,
    height: 40,
    borderRadius: RADIUS.full,
    backgroundColor: COLORS.white,
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: COLORS.black,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 3,
  },
  imageContainer: {
    width: SCREEN_WIDTH,
    height: SCREEN_WIDTH * 1.2,
    backgroundColor: COLORS.surfaceAlt,
  },
  image: {
    width: '100%',
    height: '100%',
  },
  badge: {
    position: 'absolute',
    top: SPACING.lg + 40,
    left: SPACING.lg,
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: RADIUS.sm,
    backgroundColor: COLORS.primary,
  },
  badgeSale: {
    backgroundColor: COLORS.accent,
  },
  badgeNew: {
    backgroundColor: COLORS.success,
  },
  badgeText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 11,
    color: COLORS.white,
    letterSpacing: 0.5,
  },
  infoSection: {
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.lg,
    gap: SPACING.sm,
  },
  category: {
    fontFamily: FONTS.sans.medium,
    fontSize: 11,
    color: COLORS.accent,
    letterSpacing: 2,
    textTransform: 'uppercase',
  },
  productName: {
    fontFamily: FONTS.serif.semiBold,
    fontSize: 24,
    color: COLORS.primary,
    lineHeight: 30,
  },
  ratingRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.sm,
  },
  reviewCount: {
    fontFamily: FONTS.sans.regular,
    fontSize: 12,
    color: COLORS.muted,
  },
  priceRow: {
    flexDirection: 'row',
    alignItems: 'baseline',
    gap: SPACING.sm,
  },
  price: {
    fontFamily: FONTS.sans.bold,
    fontSize: 24,
    color: COLORS.primary,
  },
  originalPrice: {
    fontFamily: FONTS.sans.regular,
    fontSize: 16,
    color: COLORS.muted,
    textDecorationLine: 'line-through',
  },
  description: {
    fontFamily: FONTS.sans.regular,
    fontSize: 14,
    color: COLORS.secondary,
    lineHeight: 22,
    marginTop: SPACING.xs,
  },
  selectorSection: {
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.lg,
    gap: SPACING.sm,
  },
  selectorLabel: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 13,
    color: COLORS.primary,
    letterSpacing: 0.3,
  },
  selectorValue: {
    fontFamily: FONTS.sans.regular,
    color: COLORS.secondary,
  },
  selectorOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: SPACING.sm,
  },
  sizeOption: {
    minWidth: 48,
    paddingHorizontal: SPACING.md,
    paddingVertical: 10,
    borderRadius: RADIUS.sm,
    borderWidth: 1,
    borderColor: COLORS.border,
    backgroundColor: COLORS.white,
    alignItems: 'center',
  },
  sizeOptionActive: {
    backgroundColor: COLORS.primary,
    borderColor: COLORS.primary,
  },
  sizeText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 13,
    color: COLORS.primary,
  },
  sizeTextActive: {
    color: COLORS.white,
  },
  colorOption: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: SPACING.md,
    paddingVertical: 10,
    borderRadius: RADIUS.sm,
    borderWidth: 1,
    borderColor: COLORS.border,
    backgroundColor: COLORS.white,
  },
  colorOptionActive: {
    backgroundColor: COLORS.primary,
    borderColor: COLORS.primary,
  },
  colorText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 13,
    color: COLORS.primary,
  },
  colorTextActive: {
    color: COLORS.white,
  },
  spacer: {
    height: SPACING.xxl,
  },
  bottomBar: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: COLORS.white,
    paddingHorizontal: SPACING.lg,
    paddingVertical: SPACING.md,
    paddingBottom: SPACING.lg,
    borderTopWidth: 1,
    borderTopColor: COLORS.borderLight,
    gap: SPACING.md,
  },
  bottomPrice: {
    gap: 2,
  },
  bottomPriceLabel: {
    fontFamily: FONTS.sans.regular,
    fontSize: 11,
    color: COLORS.muted,
  },
  bottomPriceValue: {
    fontFamily: FONTS.sans.bold,
    fontSize: 20,
    color: COLORS.primary,
  },
  addToCartBtn: {
    flex: 1,
  },
});
