import { TouchableOpacity, Text, StyleSheet, ActivityIndicator, View } from 'react-native';
import { COLORS, FONTS, SPACING, RADIUS } from '@/lib/constants';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'outline' | 'ghost' | 'accent';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  disabled?: boolean;
  icon?: React.ReactNode;
  style?: any;
}

export function Button({
  title,
  onPress,
  variant = 'primary',
  size = 'md',
  loading = false,
  disabled = false,
  icon,
  style,
}: ButtonProps) {
  const isDisabled = disabled || loading;

  return (
    <TouchableOpacity
      style={[
        styles.base,
        styles[variant],
        styles[`size_${size}`],
        isDisabled && styles.disabled,
        style,
      ]}
      onPress={onPress}
      disabled={isDisabled}
      activeOpacity={0.85}
    >
      {loading ? (
        <ActivityIndicator
          size="small"
          color={variant === 'primary' || variant === 'accent' ? COLORS.white : COLORS.primary}
        />
      ) : (
        <View style={styles.content}>
          {icon && <View style={styles.icon}>{icon}</View>}
          <Text
            style={[
              styles.text,
              styles[`text_${variant}`],
              styles[`textSize_${size}`],
            ]}
          >
            {title}
          </Text>
        </View>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  base: {
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: RADIUS.sm,
  },
  primary: {
    backgroundColor: COLORS.primary,
  },
  outline: {
    backgroundColor: 'transparent',
    borderWidth: 1.5,
    borderColor: COLORS.primary,
  },
  ghost: {
    backgroundColor: 'transparent',
  },
  accent: {
    backgroundColor: COLORS.accent,
  },
  disabled: {
    opacity: 0.45,
  },
  size_sm: {
    paddingHorizontal: SPACING.md,
    paddingVertical: 8,
  },
  size_md: {
    paddingHorizontal: SPACING.lg,
    paddingVertical: 12,
  },
  size_lg: {
    paddingHorizontal: SPACING.xl,
    paddingVertical: 16,
  },
  content: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  icon: {},
  text: {
    textAlign: 'center',
    letterSpacing: 0.5,
  },
  text_primary: {
    color: COLORS.white,
    fontFamily: FONTS.sans.semiBold,
  },
  text_outline: {
    color: COLORS.primary,
    fontFamily: FONTS.sans.semiBold,
  },
  text_ghost: {
    color: COLORS.primary,
    fontFamily: FONTS.sans.medium,
  },
  text_accent: {
    color: COLORS.white,
    fontFamily: FONTS.sans.semiBold,
  },
  textSize_sm: {
    fontSize: 12,
  },
  textSize_md: {
    fontSize: 14,
  },
  textSize_lg: {
    fontSize: 16,
  },
});
