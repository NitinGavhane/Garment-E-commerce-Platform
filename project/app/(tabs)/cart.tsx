import { View, Text, ScrollView, StyleSheet, Image, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ShoppingBag, Minus, Plus, Trash2 } from 'lucide-react-native';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';
import { useCartStore } from '@/store/cartStore';
import { CartItem } from '@/types';
import { useRouter } from 'expo-router';

export default function CartScreen() {
  const router = useRouter();
  const { items, updateQuantity, removeItem, totalPrice, clearCart } = useCartStore();

  const subtotal = totalPrice();
  const shipping = subtotal > 0 ? 12 : 0;
  const total = subtotal + shipping;

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <View style={styles.header}>
        <Text style={styles.title}>Cart</Text>
        {items.length > 0 && (
          <TouchableOpacity onPress={clearCart}>
            <Text style={styles.clearText}>Clear all</Text>
          </TouchableOpacity>
        )}
      </View>

      {items.length === 0 ? (
        <View style={styles.empty}>
          <View style={styles.emptyIcon}>
            <ShoppingBag size={40} color={COLORS.border} strokeWidth={1.2} />
          </View>
          <Text style={styles.emptyTitle}>Your cart is empty</Text>
          <Text style={styles.emptyText}>Browse our collection and add items you love</Text>
          <TouchableOpacity style={styles.shopBtn} onPress={() => router.push('/shop')}>
            <Text style={styles.shopBtnText}>Start Shopping</Text>
          </TouchableOpacity>
        </View>
      ) : (
        <>
          <ScrollView
            showsVerticalScrollIndicator={false}
            contentContainerStyle={styles.scroll}
          >
            {items.map((item, idx) => (
              <CartItemRow key={`${item.product.id}-${item.selectedSize}-${item.selectedColor}-${idx}`} item={item} />
            ))}

            {/* Order Summary */}
            <View style={styles.summary}>
              <Text style={styles.summaryTitle}>Order Summary</Text>
              <View style={styles.summaryRow}>
                <Text style={styles.summaryLabel}>Subtotal</Text>
                <Text style={styles.summaryValue}>${subtotal.toFixed(2)}</Text>
              </View>
              <View style={styles.summaryRow}>
                <Text style={styles.summaryLabel}>Shipping</Text>
                <Text style={styles.summaryValue}>${shipping.toFixed(2)}</Text>
              </View>
              <View style={styles.divider} />
              <View style={styles.summaryRow}>
                <Text style={styles.totalLabel}>Total</Text>
                <Text style={styles.totalValue}>${total.toFixed(2)}</Text>
              </View>
            </View>
          </ScrollView>

          <View style={styles.checkoutBar}>
            <View>
              <Text style={styles.checkoutTotal}>${total.toFixed(2)}</Text>
              <Text style={styles.checkoutSubLabel}>incl. shipping</Text>
            </View>
            <TouchableOpacity style={styles.checkoutBtn}>
              <Text style={styles.checkoutBtnText}>Proceed to Checkout</Text>
            </TouchableOpacity>
          </View>
        </>
      )}
    </SafeAreaView>
  );
}

function CartItemRow({ item }: { item: CartItem }) {
  const { updateQuantity, removeItem } = useCartStore();

  return (
    <View style={styles.cartItem}>
      <Image source={{ uri: item.product.image_url }} style={styles.itemImage} resizeMode="cover" />
      <View style={styles.itemInfo}>
        <Text style={styles.itemName}>{item.product.name}</Text>
        <View style={styles.itemMeta}>
          <Text style={styles.itemMetaText}>{item.selectedSize}</Text>
          <View style={styles.dot} />
          <Text style={styles.itemMetaText}>{item.selectedColor}</Text>
        </View>
        <Text style={styles.itemPrice}>${item.product.price.toFixed(0)}</Text>
        <View style={styles.qtyRow}>
          <TouchableOpacity
            style={styles.qtyBtn}
            onPress={() => updateQuantity(item.product.id, item.selectedSize, item.selectedColor, item.quantity - 1)}
          >
            <Minus size={12} color={COLORS.primary} strokeWidth={2} />
          </TouchableOpacity>
          <Text style={styles.qty}>{item.quantity}</Text>
          <TouchableOpacity
            style={styles.qtyBtn}
            onPress={() => updateQuantity(item.product.id, item.selectedSize, item.selectedColor, item.quantity + 1)}
          >
            <Plus size={12} color={COLORS.primary} strokeWidth={2} />
          </TouchableOpacity>
        </View>
      </View>
      <TouchableOpacity
        style={styles.deleteBtn}
        onPress={() => removeItem(item.product.id, item.selectedSize, item.selectedColor)}
      >
        <Trash2 size={16} color={COLORS.muted} strokeWidth={1.5} />
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  header: {
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.sm,
    paddingBottom: SPACING.md,
    flexDirection: 'row',
    alignItems: 'baseline',
    justifyContent: 'space-between',
  },
  title: {
    fontFamily: FONTS.serif.bold,
    fontSize: 28,
    color: COLORS.primary,
    letterSpacing: 0.5,
  },
  clearText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 13,
    color: COLORS.error,
  },
  empty: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: SPACING.xl,
    gap: SPACING.md,
  },
  emptyIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: COLORS.surfaceAlt,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: SPACING.sm,
  },
  emptyTitle: {
    fontFamily: FONTS.serif.semiBold,
    fontSize: 22,
    color: COLORS.primary,
    textAlign: 'center',
  },
  emptyText: {
    fontFamily: FONTS.sans.regular,
    fontSize: 14,
    color: COLORS.muted,
    textAlign: 'center',
    lineHeight: 21,
  },
  shopBtn: {
    backgroundColor: COLORS.primary,
    paddingHorizontal: SPACING.xl,
    paddingVertical: SPACING.md,
    borderRadius: RADIUS.sm,
    marginTop: SPACING.sm,
  },
  shopBtnText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 14,
    color: COLORS.white,
    letterSpacing: 0.5,
  },
  scroll: {
    padding: SPACING.lg,
    paddingTop: 0,
    gap: SPACING.md,
  },
  cartItem: {
    flexDirection: 'row',
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.md,
    overflow: 'hidden',
    gap: SPACING.md,
  },
  itemImage: {
    width: 100,
    height: 120,
  },
  itemInfo: {
    flex: 1,
    paddingVertical: SPACING.md,
    gap: 5,
  },
  itemName: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 14,
    color: COLORS.primary,
  },
  itemMeta: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  itemMetaText: {
    fontFamily: FONTS.sans.regular,
    fontSize: 12,
    color: COLORS.muted,
  },
  dot: {
    width: 3,
    height: 3,
    borderRadius: 1.5,
    backgroundColor: COLORS.muted,
  },
  itemPrice: {
    fontFamily: FONTS.sans.bold,
    fontSize: 15,
    color: COLORS.primary,
  },
  qtyRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.sm,
    marginTop: 2,
  },
  qtyBtn: {
    width: 26,
    height: 26,
    borderRadius: RADIUS.sm,
    borderWidth: 1,
    borderColor: COLORS.border,
    alignItems: 'center',
    justifyContent: 'center',
  },
  qty: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 14,
    color: COLORS.primary,
    minWidth: 20,
    textAlign: 'center',
  },
  deleteBtn: {
    padding: SPACING.md,
    alignSelf: 'flex-start',
  },
  summary: {
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.md,
    padding: SPACING.lg,
    gap: SPACING.sm,
    marginTop: SPACING.sm,
  },
  summaryTitle: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 14,
    color: COLORS.primary,
    letterSpacing: 0.5,
    marginBottom: SPACING.xs,
  },
  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  summaryLabel: {
    fontFamily: FONTS.sans.regular,
    fontSize: 14,
    color: COLORS.secondary,
  },
  summaryValue: {
    fontFamily: FONTS.sans.medium,
    fontSize: 14,
    color: COLORS.primary,
  },
  divider: {
    height: 1,
    backgroundColor: COLORS.borderLight,
    marginVertical: SPACING.xs,
  },
  totalLabel: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 16,
    color: COLORS.primary,
  },
  totalValue: {
    fontFamily: FONTS.sans.bold,
    fontSize: 18,
    color: COLORS.primary,
  },
  checkoutBar: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: COLORS.white,
    paddingHorizontal: SPACING.lg,
    paddingVertical: SPACING.md,
    borderTopWidth: 1,
    borderTopColor: COLORS.borderLight,
  },
  checkoutTotal: {
    fontFamily: FONTS.sans.bold,
    fontSize: 18,
    color: COLORS.primary,
  },
  checkoutSubLabel: {
    fontFamily: FONTS.sans.regular,
    fontSize: 11,
    color: COLORS.muted,
  },
  checkoutBtn: {
    backgroundColor: COLORS.primary,
    paddingHorizontal: SPACING.xl,
    paddingVertical: 14,
    borderRadius: RADIUS.sm,
  },
  checkoutBtnText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 14,
    color: COLORS.white,
    letterSpacing: 0.5,
  },
});
