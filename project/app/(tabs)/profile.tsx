import { View, Text, ScrollView, StyleSheet, Image, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { User, Package, Heart, MapPin, CreditCard, Settings, HelpCircle, LogOut, ChevronRight, ShoppingBag } from 'lucide-react-native';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';
import { useCartStore } from '@/store/cartStore';
import { useWishlistStore } from '@/store/wishlistStore';
import { useRouter } from 'expo-router';

const MENU_SECTIONS = [
  {
    title: 'Orders & Shipping',
    items: [
      { icon: Package, label: 'My Orders', badge: null, route: null },
      { icon: MapPin, label: 'Shipping Addresses', badge: null, route: null },
    ],
  },
  {
    title: 'Payment & Settings',
    items: [
      { icon: CreditCard, label: 'Payment Methods', badge: null, route: null },
      { icon: Settings, label: 'Settings', badge: null, route: null },
    ],
  },
  {
    title: 'Support',
    items: [
      { icon: HelpCircle, label: 'Help Center', badge: null, route: null },
    ],
  },
];

export default function ProfileScreen() {
  const router = useRouter();
  const totalCartItems = useCartStore(s => s.totalItems);
  const wishlistCount = useWishlistStore(s => s.items.length);

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        <View style={styles.header}>
          <Text style={styles.title}>Profile</Text>
        </View>

        {/* Profile Card */}
        <View style={styles.profileCard}>
          <View style={styles.avatarContainer}>
            <View style={styles.avatar}>
              <User size={36} color={COLORS.muted} strokeWidth={1.5} />
            </View>
          </View>
          <Text style={styles.profileName}>Guest User</Text>
          <Text style={styles.profileEmail}>Sign in to sync your profile</Text>
          <TouchableOpacity style={styles.signInBtn}>
            <Text style={styles.signInBtnText}>Sign In</Text>
          </TouchableOpacity>
        </View>

        {/* Stats */}
        <View style={styles.statsRow}>
          <TouchableOpacity style={styles.stat} onPress={() => router.push('/cart')}>
            <ShoppingBag size={20} color={COLORS.primary} strokeWidth={1.5} />
            <Text style={styles.statValue}>{totalCartItems()}</Text>
            <Text style={styles.statLabel}>Cart</Text>
          </TouchableOpacity>
          <View style={styles.statDivider} />
          <TouchableOpacity style={styles.stat} onPress={() => router.push('/wishlist')}>
            <Heart size={20} color={COLORS.primary} strokeWidth={1.5} />
            <Text style={styles.statValue}>{wishlistCount}</Text>
            <Text style={styles.statLabel}>Wishlist</Text>
          </TouchableOpacity>
          <View style={styles.statDivider} />
          <View style={styles.stat}>
            <Package size={20} color={COLORS.primary} strokeWidth={1.5} />
            <Text style={styles.statValue}>0</Text>
            <Text style={styles.statLabel}>Orders</Text>
          </View>
        </View>

        {/* Menu Sections */}
        {MENU_SECTIONS.map((section, sIdx) => (
          <View key={section.title} style={styles.menuSection}>
            <Text style={styles.menuSectionTitle}>{section.title}</Text>
            <View style={styles.menuCard}>
              {section.items.map((item, iIdx) => {
                const Icon = item.icon;
                return (
                  <TouchableOpacity
                    key={item.label}
                    style={[
                      styles.menuItem,
                      iIdx < section.items.length - 1 && styles.menuItemBorder,
                    ]}
                    activeOpacity={0.7}
                  >
                    <View style={styles.menuItemLeft}>
                      <View style={styles.menuIcon}>
                        <Icon size={18} color={COLORS.primary} strokeWidth={1.5} />
                      </View>
                      <Text style={styles.menuLabel}>{item.label}</Text>
                    </View>
                    <ChevronRight size={16} color={COLORS.muted} strokeWidth={1.5} />
                  </TouchableOpacity>
                );
              })}
            </View>
          </View>
        ))}

        {/* Sign Out */}
        <TouchableOpacity style={styles.logoutBtn}>
          <LogOut size={16} color={COLORS.error} strokeWidth={1.5} />
          <Text style={styles.logoutText}>Sign Out</Text>
        </TouchableOpacity>

        <Text style={styles.version}>Version 1.0.0</Text>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  scroll: {
    paddingBottom: SPACING.xxl,
  },
  header: {
    paddingHorizontal: SPACING.lg,
    paddingTop: SPACING.sm,
    paddingBottom: SPACING.md,
  },
  title: {
    fontFamily: FONTS.serif.bold,
    fontSize: 28,
    color: COLORS.primary,
    letterSpacing: 0.5,
  },
  profileCard: {
    backgroundColor: COLORS.white,
    marginHorizontal: SPACING.lg,
    borderRadius: RADIUS.lg,
    padding: SPACING.xl,
    alignItems: 'center',
    gap: SPACING.sm,
    marginBottom: SPACING.lg,
  },
  avatarContainer: {
    marginBottom: SPACING.xs,
  },
  avatar: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: COLORS.surfaceAlt,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: COLORS.border,
  },
  profileName: {
    fontFamily: FONTS.serif.semiBold,
    fontSize: 22,
    color: COLORS.primary,
  },
  profileEmail: {
    fontFamily: FONTS.sans.regular,
    fontSize: 13,
    color: COLORS.muted,
  },
  signInBtn: {
    backgroundColor: COLORS.primary,
    paddingHorizontal: SPACING.xl,
    paddingVertical: 10,
    borderRadius: RADIUS.sm,
    marginTop: SPACING.sm,
  },
  signInBtnText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 13,
    color: COLORS.white,
    letterSpacing: 0.5,
  },
  statsRow: {
    flexDirection: 'row',
    backgroundColor: COLORS.white,
    marginHorizontal: SPACING.lg,
    borderRadius: RADIUS.lg,
    padding: SPACING.lg,
    marginBottom: SPACING.lg,
    alignItems: 'center',
  },
  stat: {
    flex: 1,
    alignItems: 'center',
    gap: 4,
  },
  statDivider: {
    width: 1,
    height: 36,
    backgroundColor: COLORS.borderLight,
  },
  statValue: {
    fontFamily: FONTS.sans.bold,
    fontSize: 18,
    color: COLORS.primary,
  },
  statLabel: {
    fontFamily: FONTS.sans.regular,
    fontSize: 11,
    color: COLORS.muted,
    letterSpacing: 0.3,
  },
  menuSection: {
    marginBottom: SPACING.lg,
    paddingHorizontal: SPACING.lg,
  },
  menuSectionTitle: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 11,
    color: COLORS.muted,
    letterSpacing: 1.5,
    marginBottom: SPACING.sm,
    paddingHorizontal: SPACING.xs,
  },
  menuCard: {
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.lg,
    overflow: 'hidden',
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: SPACING.lg,
    paddingVertical: 16,
  },
  menuItemBorder: {
    borderBottomWidth: 1,
    borderBottomColor: COLORS.borderLight,
  },
  menuItemLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.md,
  },
  menuIcon: {
    width: 36,
    height: 36,
    borderRadius: RADIUS.md,
    backgroundColor: COLORS.surfaceAlt,
    alignItems: 'center',
    justifyContent: 'center',
  },
  menuLabel: {
    fontFamily: FONTS.sans.medium,
    fontSize: 14,
    color: COLORS.primary,
    letterSpacing: 0.2,
  },
  logoutBtn: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: SPACING.sm,
    marginHorizontal: SPACING.lg,
    paddingVertical: SPACING.md,
    borderRadius: RADIUS.lg,
    borderWidth: 1,
    borderColor: COLORS.border,
  },
  logoutText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 14,
    color: COLORS.error,
  },
  version: {
    fontFamily: FONTS.sans.regular,
    fontSize: 11,
    color: COLORS.muted,
    textAlign: 'center',
    marginTop: SPACING.xl,
  },
});
