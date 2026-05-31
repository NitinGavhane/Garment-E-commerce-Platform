import { create } from 'zustand';
import { Product } from '@/types';

interface WishlistStore {
  items: Product[];
  addItem: (product: Product) => void;
  removeItem: (productId: string) => void;
  isWishlisted: (productId: string) => boolean;
  toggle: (product: Product) => void;
}

export const useWishlistStore = create<WishlistStore>((set, get) => ({
  items: [],

  addItem: (product) => {
    if (!get().isWishlisted(product.id)) {
      set({ items: [...get().items, product] });
    }
  },

  removeItem: (productId) => {
    set({ items: get().items.filter(p => p.id !== productId) });
  },

  isWishlisted: (productId) => get().items.some(p => p.id === productId),

  toggle: (product) => {
    if (get().isWishlisted(product.id)) {
      get().removeItem(product.id);
    } else {
      get().addItem(product);
    }
  },
}));
