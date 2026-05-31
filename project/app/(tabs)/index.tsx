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
  FlatList,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { LinearGradient } from 'expo-linear-gradient';
import { Search, Bell, ArrowRight } from 'lucide-react-native';
import { supabase } from '@/lib/supabase';
import { Category, Product } from '@/types';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';
import { ProductCard } from '@/components/ProductCard';
import { CategoryCard } from '@/components/CategoryCard';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const CARD_WIDTH = (SCREEN_WIDTH - SPACING.lg * 2 - SPACING.md) / 2;

export default function HomeScreen() {
  const router = useRouter();
  const [categories, setCategories] = useState<Category[]>([]);
  const [featured, setFeatured] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, []);

  async function fetchData() {
    try {
      const [catRes, prodRes] = await Promise.all([
        supabase.from('categories').select('*').order('name'),
        supabase
          .from('products')
          .select('*, category:categories(*)')
          .eq('is_featured', true)
          .order('created_at', { ascending: false }),
      ]);
      if (catRes.data) setCategories(catRes.data);
      if (prodRes.data) setFeatured(prodRes.data as Product[]);
    } finally {
      setLoading(false);
    }
  }

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={styles.scroll}
      >
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={styles.brandTagline}>MODERN MENSWEAR</Text>
            <Text style={styles.brandName}>MEN'S</Text>
          </View>
          <View style={styles.headerActions}>
            <TouchableOpacity style={styles.iconBtn} onPress={() => router.push('/shop')}>
              <Search size={20} color={COLORS.primary} strokeWidth={1.5} />
            </TouchableOpacity>
            <TouchableOpacity style={styles.iconBtn}>
              <Bell size={20} color={COLORS.primary} strokeWidth={1.5} />
            </TouchableOpacity>
          </View>
        </View>

        {/* Hero Banner */}
        <View style={styles.hero}>
          <Image
            source={{ uri: 'https://images.pexels.com/photos/2526878/pexels-photo-2526878.jpeg?auto=compress&cs=tinysrgb&w=800' }}
            style={styles.heroImage}
            resizeMode="cover"
          />
          <LinearGradient
            colors={['transparent', 'rgba(0,0,0,0.72)']}
            style={styles.heroGradient}
          />
          <View style={styles.heroContent}>
            <Text style={styles.heroSubtitle}>New Season 2026</Text>
            <Text style={styles.heroTitle}>Define{'\n'}Your Style</Text>
            <Text style={styles.heroDesc}>Modern Menswear for Every Occasion</Text>
            <View style={styles.heroBtns}>
              <TouchableOpacity
                style={styles.heroBtn}
                onPress={() => router.push('/shop')}
              >
                <Text style={styles.heroBtnText}>Shop Now</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.heroBtnOutline}
                onPress={() => router.push('/shop')}
              >
                <Text style={styles.heroBtnOutlineText}>New Arrivals</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>

        {/* Categories */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <View style={styles.sectionTitleRow}>
              <View style={styles.sectionLine} />
              <Text style={styles.sectionTitle}>ESSENTIALS</Text>
            </View>
            <TouchableOpacity
              style={styles.seeAll}
              onPress={() => router.push('/shop')}
            >
              <Text style={styles.seeAllText}>See all</Text>
              <ArrowRight size={12} color={COLORS.accent} strokeWidth={2} />
            </TouchableOpacity>
          </View>

          {loading ? (
            <ActivityIndicator color={COLORS.accent} style={{ marginVertical: SPACING.lg }} />
          ) : (
            <ScrollView
              horizontal
              showsHorizontalScrollIndicator={false}
              contentContainerStyle={styles.categoriesScroll}
            >
              {categories.map(cat => (
                <CategoryCard
                  key={cat.id}
                  category={cat}
                  onPress={() => router.push({ pathname: '/shop', params: { category: cat.slug } })}
                />
              ))}
            </ScrollView>
          )}
        </View>

        {/* Promo Banner */}
        <TouchableOpacity style={styles.promoBanner} activeOpacity={0.9} onPress={() => router.push('/shop')}>
          <Image
            source={{ uri: 'https://images.pexels.com/photos/2897883/pexels-photo-2897883.jpeg?auto=compress&cs=tinysrgb&w=800' }}
            style={styles.promoImage}
            resizeMode="cover"
          />
          <LinearGradient
            colors={['rgba(0,0,0,0.55)', 'transparent']}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 0 }}
            style={styles.promoGradient}
          />
          <View style={styles.promoContent}>
            <Text style={styles.promoTitle}>Autumn Collection</Text>
            <Text style={styles.promoOffer}>Up to 30% OFF</Text>
            <TouchableOpacity style={styles.promoBtn} onPress={() => router.push('/shop')}>
              <Text style={styles.promoBtnText}>SHOP COLLECTION</Text>
            </TouchableOpacity>
          </View>
        </TouchableOpacity>

        {/* Trending Products */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <View style={styles.sectionTitleRow}>
              <View style={styles.sectionLine} />
              <Text style={styles.sectionTitle}>TRENDING NOW</Text>
            </View>
            <TouchableOpacity style={styles.seeAll} onPress={() => router.push('/shop')}>
              <Text style={styles.seeAllText}>See all</Text>
              <ArrowRight size={12} color={COLORS.accent} strokeWidth={2} />
            </TouchableOpacity>
          </View>

          {loading ? (
            <ActivityIndicator color={COLORS.accent} style={{ marginVertical: SPACING.lg }} />
          ) : (
            <View style={styles.productsGrid}>
              {featured.map(product => (
                <ProductCard key={product.id} product={product} width={CARD_WIDTH} />
              ))}
            </View>
          )}
        </View>

        {/* Style Guide Banner */}
        <View style={styles.styleBanner}>
          <Text style={styles.styleTitle}>Style Guide</Text>
          <Text style={styles.styleSubtitle}>Discover curated looks for every occasion</Text>
          <TouchableOpacity style={styles.styleBtn} onPress={() => router.push('/shop')}>
            <Text style={styles.styleBtnText}>Explore Lookbook</Text>
            <ArrowRight size={14} color={COLORS.accent} strokeWidth={2} />
          </TouchableOpacity>
        </View>
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
    paddingBottom: SPACING.xl,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: SPACING.lg,
    paddingVertical: SPACING.md,
    backgroundColor: COLORS.background,
  },
  brandTagline: {
    fontFamily: FONTS.sans.light,
    fontSize: 9,
    letterSpacing: 2.5,
    color: COLORS.muted,
  },
  brandName: {
    fontFamily: FONTS.serif.bold,
    fontSize: 24,
    color: COLORS.primary,
    letterSpacing: 3,
  },
  headerActions: {
    flexDirection: 'row',
    gap: SPACING.sm,
  },
  iconBtn: {
    width: 38,
    height: 38,
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: RADIUS.full,
    backgroundColor: COLORS.white,
    borderWidth: 1,
    borderColor: COLORS.borderLight,
  },
  hero: {
    height: 480,
    marginHorizontal: SPACING.lg,
    borderRadius: RADIUS.lg,
    overflow: 'hidden',
    marginBottom: SPACING.xl,
  },
  heroImage: {
    width: '100%',
    height: '100%',
  },
  heroGradient: {
    ...StyleSheet.absoluteFillObject,
  },
  heroContent: {
    position: 'absolute',
    bottom: SPACING.xl,
    left: SPACING.xl,
    right: SPACING.xl,
  },
  heroSubtitle: {
    fontFamily: FONTS.sans.light,
    fontSize: 11,
    letterSpacing: 2.5,
    color: 'rgba(255,255,255,0.8)',
    marginBottom: SPACING.xs,
  },
  heroTitle: {
    fontFamily: FONTS.serif.bold,
    fontSize: 48,
    color: COLORS.white,
    lineHeight: 54,
    marginBottom: SPACING.sm,
  },
  heroDesc: {
    fontFamily: FONTS.sans.light,
    fontSize: 14,
    color: 'rgba(255,255,255,0.75)',
    marginBottom: SPACING.lg,
    letterSpacing: 0.3,
  },
  heroBtns: {
    flexDirection: 'row',
    gap: SPACING.sm,
    flexWrap: 'wrap',
  },
  heroBtn: {
    backgroundColor: COLORS.white,
    paddingHorizontal: SPACING.lg,
    paddingVertical: 12,
    borderRadius: RADIUS.sm,
  },
  heroBtnText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 13,
    color: COLORS.primary,
    letterSpacing: 0.5,
  },
  heroBtnOutline: {
    borderWidth: 1.5,
    borderColor: 'rgba(255,255,255,0.7)',
    paddingHorizontal: SPACING.lg,
    paddingVertical: 12,
    borderRadius: RADIUS.sm,
  },
  heroBtnOutlineText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 13,
    color: COLORS.white,
    letterSpacing: 0.5,
  },
  section: {
    marginBottom: SPACING.xl,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: SPACING.lg,
    marginBottom: SPACING.md,
  },
  sectionTitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: SPACING.sm,
  },
  sectionLine: {
    width: 20,
    height: 1.5,
    backgroundColor: COLORS.primary,
  },
  sectionTitle: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 12,
    letterSpacing: 2,
    color: COLORS.primary,
  },
  seeAll: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 3,
  },
  seeAllText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 12,
    color: COLORS.accent,
    letterSpacing: 0.3,
  },
  categoriesScroll: {
    paddingHorizontal: SPACING.lg,
    gap: SPACING.md,
  },
  promoBanner: {
    marginHorizontal: SPACING.lg,
    height: 180,
    borderRadius: RADIUS.lg,
    overflow: 'hidden',
    marginBottom: SPACING.xl,
  },
  promoImage: {
    width: '100%',
    height: '100%',
  },
  promoGradient: {
    ...StyleSheet.absoluteFillObject,
  },
  promoContent: {
    position: 'absolute',
    left: SPACING.xl,
    top: 0,
    bottom: 0,
    justifyContent: 'center',
    maxWidth: '55%',
  },
  promoTitle: {
    fontFamily: FONTS.serif.bold,
    fontSize: 24,
    color: COLORS.white,
    lineHeight: 28,
  },
  promoOffer: {
    fontFamily: FONTS.serif.italic,
    fontSize: 18,
    color: COLORS.white,
    marginBottom: SPACING.md,
  },
  promoBtn: {
    backgroundColor: COLORS.accent,
    paddingHorizontal: SPACING.md,
    paddingVertical: 8,
    borderRadius: RADIUS.sm,
    alignSelf: 'flex-start',
  },
  promoBtnText: {
    fontFamily: FONTS.sans.semiBold,
    fontSize: 10,
    letterSpacing: 1.5,
    color: COLORS.white,
  },
  productsGrid: {
    paddingHorizontal: SPACING.lg,
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: SPACING.md,
  },
  styleBanner: {
    marginHorizontal: SPACING.lg,
    backgroundColor: COLORS.primary,
    borderRadius: RADIUS.lg,
    padding: SPACING.xl,
    alignItems: 'center',
    gap: SPACING.sm,
  },
  styleTitle: {
    fontFamily: FONTS.serif.bold,
    fontSize: 28,
    color: COLORS.white,
    letterSpacing: 0.5,
  },
  styleSubtitle: {
    fontFamily: FONTS.sans.regular,
    fontSize: 13,
    color: 'rgba(255,255,255,0.65)',
    textAlign: 'center',
    letterSpacing: 0.3,
  },
  styleBtn: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginTop: SPACING.sm,
    borderBottomWidth: 1,
    borderBottomColor: COLORS.accent,
    paddingBottom: 2,
  },
  styleBtnText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 13,
    color: COLORS.accent,
    letterSpacing: 0.5,
  },
});
