import { TouchableOpacity, View, Text, Image, StyleSheet } from 'react-native';
import { Category } from '@/types';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';

interface CategoryCardProps {
  category: Category;
  onPress?: () => void;
  selected?: boolean;
}

export function CategoryCard({ category, onPress, selected }: CategoryCardProps) {
  return (
    <TouchableOpacity style={styles.card} onPress={onPress} activeOpacity={0.88}>
      <View style={[styles.imageContainer, selected && styles.imageContainerSelected]}>
        <Image
          source={{ uri: category.image_url }}
          style={styles.image}
          resizeMode="cover"
        />
        {selected && <View style={styles.overlay} />}
      </View>
      <Text style={[styles.label, selected && styles.labelSelected]}>{category.name}</Text>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    alignItems: 'center',
    gap: SPACING.xs,
    width: 88,
  },
  imageContainer: {
    width: 80,
    height: 100,
    borderRadius: RADIUS.md,
    overflow: 'hidden',
    borderWidth: 2,
    borderColor: 'transparent',
  },
  imageContainerSelected: {
    borderColor: COLORS.accent,
  },
  image: {
    width: '100%',
    height: '100%',
  },
  overlay: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'rgba(139,107,61,0.25)',
  },
  label: {
    fontFamily: FONTS.sans.medium,
    fontSize: 11,
    color: COLORS.secondary,
    textAlign: 'center',
    letterSpacing: 0.3,
  },
  labelSelected: {
    color: COLORS.accent,
    fontFamily: FONTS.sans.semiBold,
  },
});
