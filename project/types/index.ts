export interface Category {
  id: string;
  name: string;
  slug: string;
  image_url: string;
  created_at: string;
}

export interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
  original_price: number | null;
  image_url: string;
  category_id: string | null;
  rating: number;
  review_count: number;
  badge: string | null;
  sizes: string[];
  colors: string[];
  is_featured: boolean;
  in_stock: boolean;
  created_at: string;
  category?: Category;
}

export interface CartItem {
  product: Product;
  quantity: number;
  selectedSize: string;
  selectedColor: string;
}
