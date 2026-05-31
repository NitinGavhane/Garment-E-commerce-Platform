import { useEffect, useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  TextInput,
  StyleSheet,
  Dimensions,
  ActivityIndicator,
  TouchableOpacity,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useLocalSearchParams } from 'expo-router';
import { Search, SlidersHorizontal, X } from 'lucide-react-native';
import { supabase } from '@/lib/supabase';
import { Category, Product } from '@/types';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';
import { ProductCard } from '@/components/ProductCard';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const CARD_WIDTH = (SCREEN_WIDTH - SPACING.lg * 2 - SPACING.md) / 2;

const SORT_OPTIONS = ['Newest', 'Price: Low', 'Price: High', 'Rating'];

export default function ShopScreen() {
  const { category: categoryParam } = useLocalSearchParams<{ category?: string }>();
  const [categories, setCategories] = useState<Category[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string | null>(categoryParam ?? null);
  const [selectedSort, setSelectedSort] = useState('Newest');

  useEffect(() => {
    supabase.from('categories').select('*').order('name').then(({ data }) => {
      if (data) setCategories(data);
    });
  }, []);

  useEffect(() => {
    fetchProducts();
  }, [selectedCategory, selectedSort]);

  async function fetchProducts() {
    setLoading(true);
    let query = supabase
      .from('products')
      .select('*, category:categories(*)')
      .eq('in_stock', true);

    if (selectedCategory) {
      const cat = categories.find(c => c.slug === selectedCategory);
      if (cat) query = query.eq('category_id', cat.id);
    }

    if (selectedSort === 'Price: Low') query = query.order('price', { ascending: true });
    else if (selectedSort === 'Price: High') query = query.order('price', { ascending: false });
    else if (selectedSort === 'Rating') query = query.order('rating', { ascending: false });
    else query = query.order('created_at', { ascending: false });

    const { data } = await query;
    if (data) setProducts(data as Product[]);
    setLoading(false);
  }

  const filtered = products.filter(p =>
    search.trim() === '' || p.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Shop</Text>
        <Text style={styles.subtitle}>{filtered.length} items</Text>
      </View>

      {/* Search Bar */}
      <View style={styles.searchRow}>
        <View style={styles.searchContainer}>
          <Search size={16} color={COLORS.muted} strokeWidth={1.5} />
          <TextInput
            style={styles.searchInput}
            placeholder="Search products..."
            placeholderTextColor={COLORS.muted}
            value={search}
            onChangeText={setSearch}
          />
          {search.length > 0 && (
            <TouchableOpacity onPress={() => setSearch('')}>
              <X size={14} color={COLORS.muted} strokeWidth={2} />
            </TouchableOpacity>
          )}
        </View>
        <TouchableOpacity style={styles.filterBtn}>
          <SlidersHorizontal size={18} color={COLORS.primary} strokeWidth={1.5} />
        </TouchableOpacity>
      </View>

      {/* Categories Filter */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.filterScroll}
        style={styles.filterScrollView}
      >
        <TouchableOpacity
          style={[styles.filterChip, !selectedCategory && styles.filterChipActive]}
          onPress={() => setSelectedCategory(null)}
        >
          <Text style={[styles.filterChipText, !selectedCategory && styles.filterChipTextActive]}>
            All
          </Text>
        </TouchableOpacity>
        {categories.map(cat => (
          <TouchableOpacity
            key={cat.id}
            style={[styles.filterChip, selectedCategory === cat.slug && styles.filterChipActive]}
            onPress={() => setSelectedCategory(selectedCategory === cat.slug ? null : cat.slug)}
          >
            <Text style={[styles.filterChipText, selectedCategory === cat.slug && styles.filterChipTextActive]}>
              {cat.name}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* Sort */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.sortScroll}
        style={styles.sortScrollView}
      >
        {SORT_OPTIONS.map(opt => (
          <TouchableOpacity
            key={opt}
            style={[styles.sortChip, selectedSort === opt && styles.sortChipActive]}
            onPress={() => setSelectedSort(opt)}
          >
            <Text style={[styles.sortChipText, selectedSort === opt && styles.sortChipTextActive]}>
              {opt}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* Products Grid */}
      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={styles.scroll}
      >
        {loading ? (
          <ActivityIndicator color={COLORS.accent} style={{ marginTop: SPACING.xxl }} />
        ) : filtered.length === 0 ? (
          <View style={styles.empty}>
            <Text style={styles.emptyTitle}>No products found</Text>
            <Text style={styles.emptyText}>Try adjusting your search or filters</Text>
          </View>
        ) : (
          <View style={styles.grid}>
            {filtered.map(product => (
              <ProductCard key={product.id} product={product} width={CARD_WIDTH} />
            ))}
          </View>
        )}
      </ScrollView>
    </SafeAreaView>
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
    paddingBottom: SPACING.xs,
    flexDirection: 'row',
    alignItems: 'baseline',
    gap: SPACING.sm,
  },
  title: {
    fontFamily: FONTS.serif.bold,
    fontSize: 28,
    color: COLORS.primary,
    letterSpacing: 0.5,
  },
  subtitle: {
    fontFamily: FONTS.sans.regular,
    fontSize: 13,
    color: COLORS.muted,
  },
  searchRow: {
    flexDirection: 'row',
    gap: SPACING.sm,
    paddingHorizontal: SPACING.lg,
    paddingVertical: SPACING.sm,
  },
  searchContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.full,
    paddingHorizontal: SPACING.md,
    height: 44,
    gap: SPACING.sm,
    borderWidth: 1,
    borderColor: COLORS.borderLight,
  },
  searchInput: {
    flex: 1,
    fontFamily: FONTS.sans.regular,
    fontSize: 14,
    color: COLORS.primary,
    height: '100%',
  },
  filterBtn: {
    width: 44,
    height: 44,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: COLORS.white,
    borderRadius: RADIUS.full,
    borderWidth: 1,
    borderColor: COLORS.borderLight,
  },
  filterScrollView: {
    maxHeight: 48,
  },
  filterScroll: {
    paddingHorizontal: SPACING.lg,
    gap: SPACING.sm,
    paddingVertical: SPACING.xs,
  },
  filterChip: {
    paddingHorizontal: SPACING.md,
    paddingVertical: 7,
    borderRadius: RADIUS.full,
    backgroundColor: COLORS.white,
    borderWidth: 1,
    borderColor: COLORS.border,
  },
  filterChipActive: {
    backgroundColor: COLORS.primary,
    borderColor: COLORS.primary,
  },
  filterChipText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 12,
    color: COLORS.secondary,
    letterSpacing: 0.3,
  },
  filterChipTextActive: {
    color: COLORS.white,
  },
  sortScrollView: {
    maxHeight: 44,
    marginTop: 2,
  },
  sortScroll: {
    paddingHorizontal: SPACING.lg,
    gap: SPACING.sm,
    paddingVertical: SPACING.xs,
  },
  sortChip: {
    paddingHorizontal: SPACING.md,
    paddingVertical: 6,
    borderRadius: RADIUS.sm,
    borderBottomWidth: 2,
    borderBottomColor: 'transparent',
  },
  sortChipActive: {
    borderBottomColor: COLORS.accent,
  },
  sortChipText: {
    fontFamily: FONTS.sans.medium,
    fontSize: 12,
    color: COLORS.muted,
    letterSpacing: 0.3,
  },
  sortChipTextActive: {
    color: COLORS.accent,
  },
  scroll: {
    padding: SPACING.lg,
    paddingTop: SPACING.md,
  },
  grid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: SPACING.md,
  },
  empty: {
    alignItems: 'center',
    paddingTop: SPACING.xxl,
    gap: SPACING.sm,
  },
  emptyTitle: {
    fontFamily: FONTS.serif.semiBold,
    fontSize: 20,
    color: COLORS.primary,
  },
  emptyText: {
    fontFamily: FONTS.sans.regular,
    fontSize: 14,
    color: COLORS.muted,
    textAlign: 'center',
  },
});
