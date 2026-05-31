import { View, StyleSheet } from 'react-native';
import { Star } from 'lucide-react-native';
import { COLORS } from '@/lib/constants';

interface StarRatingProps {
  rating: number;
  size?: number;
}

export function StarRating({ rating, size = 12 }: StarRatingProps) {
  return (
    <View style={styles.row}>
      {[1, 2, 3, 4, 5].map(i => (
        <Star
          key={i}
          size={size}
          color={i <= Math.round(rating) ? COLORS.warning : COLORS.border}
          fill={i <= Math.round(rating) ? COLORS.warning : 'transparent'}
          strokeWidth={1.5}
        />
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 1,
  },
});
