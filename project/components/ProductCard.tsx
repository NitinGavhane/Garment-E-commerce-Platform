import { TouchableOpacity, View, Text, Image, StyleSheet } from 'react-native';
import { Heart } from 'lucide-react-native';
import { useRouter } from 'expo-router';
import { Product } from '@/types';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';
import { StarRating } from './StarRating';
import { useWishlistStore } from '@/store/wishlistStore';

interface ProductCardProps {
  product: Product;
  width?: number;
}

export function ProductCard({ product, width }: ProductCardProps) {
  const router = useRouter();
  const { isWishlisted, toggle } = useWishlistStore();
  const wishlisted = isWishlisted(product.id);

  return (
    <TouchableOpacity
      style={[styles.card, width ? { width } : {}]}
      onPress={() => router.push({ pathname: '/product/[id]', params: { id: product.id } })}
      activeOpacity={0.92}
    >
      <View style={styles.imageContainer}>
        <Image
          source={{ uri: product.image_url }}
          style={styles.image}
          resizeMode="cover"
        />
        {product.badge && (
          <View style={[styles.badge, product.badge === 'Sale' && styles.badgeSale, product.badge === 'New' && styles.badgeNew]}>
            <Text style={styles.badgeText}>{product.badge}</Text>
          </View>
        )}
        <TouchableOpacity
          style={styles.heartBtn}
          onPress={() => toggle(product)}
          hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
        >
          <Heart
            size={16}
            color={wishlisted ? COLORS.error : COLORS.secondary}
            fill={wishlisted ? COLORS.error : 'transparent'}
            strokeWidth={1.5}
          />
        </TouchableOpacity>
      </View>
      <View style={styles.info}>
        <Text style={styles.name} numberOfLines={1}>{product.name}</Text>
        <View style={styles.ratingRow}>
          <StarRating rating={product.rating} size={10} />
          <Text style={styles.reviewCount}>({product.review_count})</Text>
        </View>
        <View style={styles.priceRow}>
          <Text style={styles.price}>${product.price.toFixed(0)}</Text>
          {product.original_price && (
            <Text style={styles.originalPrice}>${product.original_price.toFixed(0)}</Text>
          )}
        </View>
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.md,
    overflow: 'hidden',
  },
  imageContainer: {
    position: 'relative',
    aspectRatio: 3 / 4,
    backgroundColor: COLORS.surfaceAlt,
  },
  image: {
    width: '100%',
    height: '100%',
  },
  badge: {
    position: 'absolute',
    top: SPACING.sm,
    left: SPACING.sm,
    backgroundColor: COLORS.primary,
    paddingHorizontal: 8,
    paddingVertical: 3,
    borderRadius: RADIUS.sm,
  },
  badgeSale: {
    backgroundColor: COLORS.accent,
  },
  badgeNew: {
    backgroundColor: COLORS.success,
  },
  badgeText: {
    color: COLORS.white,
    fontFamily: FONTS.sans.medium,
    fontSize: 10,
    letterSpacing: 0.5,
  },
  heartBtn: {
    position: 'absolute',
    top: SPACING.sm,
    right: SPACING.sm,
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.full,
    width: 30,
    height: 30,
    alignItems: 'center',
    justifyContent: 'center',
  },
  info: {
    padding: SPACING.sm,
    paddingTop: SPACING.xs + 2,
    gap: 3,
  },
  name: {
    fontFamily: FONTS.sans.medium,
    fontSize: 13,
    color: COLORS.primary,
    letterSpacing: 0.2,
  },
  ratingRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  reviewCount: {
    fontFamily: FONTS.sans.regular,
    fontSize: 10,
    color: COLORS.muted,
  },
  priceRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.xs,
  },
  price: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 14,
    color: COLORS.primary,
  },
  originalPrice: {
    fontFamily: FONTS.sans.regular,
    fontSize: 12,
    color: COLORS.muted,
    textDecorationLine: 'line-through',
  },
});
