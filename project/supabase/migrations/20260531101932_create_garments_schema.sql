/*
  # Garments Products Schema

  1. New Tables
    - `categories`
      - `id` (uuid, primary key)
      - `name` (text, unique) - Category display name
      - `slug` (text, unique) - URL-friendly identifier
      - `image_url` (text) - Pexels image URL
      - `created_at` (timestamptz)

    - `products`
      - `id` (uuid, primary key)
      - `name` (text) - Product display name
      - `description` (text) - Product description
      - `price` (numeric) - Current price
      - `original_price` (numeric, nullable) - Original price for sale items
      - `image_url` (text) - Main product image
      - `category_id` (uuid, FK -> categories.id)
      - `rating` (numeric) - Average rating (0-5)
      - `review_count` (integer) - Number of reviews
      - `badge` (text, nullable) - Badge label e.g. "Sale", "New", "Setup"
      - `sizes` (text[]) - Available sizes
      - `colors` (text[]) - Available colors
      - `is_featured` (boolean) - Featured/trending product
      - `in_stock` (boolean) - Availability
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on both tables
    - Add public read-only policies (products catalog is publicly viewable)

  3. Seed Data
    - 5 categories: Casual Wear, Formal Wear, Street Style, Outerwear, Accessories
    - 12 products across categories
*/

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  slug text UNIQUE NOT NULL,
  image_url text NOT NULL DEFAULT '',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view categories"
  ON categories FOR SELECT
  TO anon, authenticated
  USING (true);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NOT NULL DEFAULT '',
  price numeric(10,2) NOT NULL,
  original_price numeric(10,2),
  image_url text NOT NULL DEFAULT '',
  category_id uuid REFERENCES categories(id) ON DELETE SET NULL,
  rating numeric(3,2) NOT NULL DEFAULT 0,
  review_count integer NOT NULL DEFAULT 0,
  badge text,
  sizes text[] NOT NULL DEFAULT '{}',
  colors text[] NOT NULL DEFAULT '{}',
  is_featured boolean NOT NULL DEFAULT false,
  in_stock boolean NOT NULL DEFAULT true,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view products"
  ON products FOR SELECT
  TO anon, authenticated
  USING (true);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS products_category_id_idx ON products(category_id);
CREATE INDEX IF NOT EXISTS products_is_featured_idx ON products(is_featured);
CREATE INDEX IF NOT EXISTS products_in_stock_idx ON products(in_stock);

-- Seed categories
INSERT INTO categories (name, slug, image_url) VALUES
  ('Casual Wear', 'casual-wear', 'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&w=400'),
  ('Formal Wear', 'formal-wear', 'https://images.pexels.com/photos/2897883/pexels-photo-2897883.jpeg?auto=compress&cs=tinysrgb&w=400'),
  ('Street Style', 'street-style', 'https://images.pexels.com/photos/1124468/pexels-photo-1124468.jpeg?auto=compress&cs=tinysrgb&w=400'),
  ('Outerwear', 'outerwear', 'https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?auto=compress&cs=tinysrgb&w=400'),
  ('Accessories', 'accessories', 'https://images.pexels.com/photos/1007018/pexels-photo-1007018.jpeg?auto=compress&cs=tinysrgb&w=400')
ON CONFLICT (slug) DO NOTHING;

-- Seed products
INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Beige Bomber Jacket',
  'A relaxed-fit bomber in premium suede-touch fabric. Perfect for weekend outings and casual occasions.',
  149.00,
  NULL,
  'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.8, 124,
  NULL,
  ARRAY['XS','S','M','L','XL'],
  ARRAY['Beige','Olive','Black'],
  true, true
FROM categories c WHERE c.slug = 'casual-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Smart Casual Blazer',
  'Refined and versatile, this slim-cut blazer transitions effortlessly from desk to dinner.',
  199.00,
  NULL,
  'https://images.pexels.com/photos/2897883/pexels-photo-2897883.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.7, 89,
  NULL,
  ARRAY['S','M','L','XL','XXL'],
  ARRAY['Navy','Charcoal','Camel'],
  true, true
FROM categories c WHERE c.slug = 'formal-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Knitted Polo Shirt',
  'A classic polo in soft merino-blend knit. Clean, minimal, and endlessly wearable.',
  79.00,
  119.00,
  'https://images.pexels.com/photos/1124468/pexels-photo-1124468.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.5, 312,
  'Sale',
  ARRAY['XS','S','M','L','XL'],
  ARRAY['White','Stone','Black','Navy'],
  true, true
FROM categories c WHERE c.slug = 'casual-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Textured Wool Coat',
  'A statement overcoat in a rich textured wool blend. Tailored silhouette for a polished look.',
  229.00,
  NULL,
  'https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.9, 56,
  'New',
  ARRAY['S','M','L','XL'],
  ARRAY['Camel','Dark Brown','Slate'],
  true, true
FROM categories c WHERE c.slug = 'outerwear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Slim Chino Trousers',
  'Tailored slim chinos in a wrinkle-resistant cotton blend. A wardrobe essential.',
  89.00,
  NULL,
  'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.6, 203,
  NULL,
  ARRAY['28','30','32','34','36'],
  ARRAY['Khaki','Navy','Olive','Black'],
  false, true
FROM categories c WHERE c.slug = 'casual-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Oxford Button-Down Shirt',
  'Crafted from premium Oxford cotton with a clean, classic fit. A true wardrobe staple.',
  95.00,
  135.00,
  'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.4, 178,
  'Sale',
  ARRAY['XS','S','M','L','XL','XXL'],
  ARRAY['White','Light Blue','Pink','Stripe'],
  false, true
FROM categories c WHERE c.slug = 'formal-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Graphic Oversized Tee',
  'Street-ready oversized tee with a minimalist graphic print. Soft cotton jersey.',
  49.00,
  NULL,
  'https://images.pexels.com/photos/2897531/pexels-photo-2897531.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.3, 445,
  NULL,
  ARRAY['S','M','L','XL','XXL'],
  ARRAY['White','Black','Stone','Moss'],
  false, true
FROM categories c WHERE c.slug = 'street-style'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Cargo Utility Pants',
  'Modern cargo trousers with a relaxed fit and multiple utility pockets. Urban and functional.',
  119.00,
  NULL,
  'https://images.pexels.com/photos/1036627/pexels-photo-1036627.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.5, 167,
  'New',
  ARRAY['28','30','32','34','36'],
  ARRAY['Olive','Black','Stone'],
  false, true
FROM categories c WHERE c.slug = 'street-style'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Leather Tote Bag',
  'Full-grain leather tote with suede interior lining. Spacious and sophisticated.',
  189.00,
  NULL,
  'https://images.pexels.com/photos/1007018/pexels-photo-1007018.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.8, 92,
  NULL,
  ARRAY['One Size'],
  ARRAY['Tan','Black','Dark Brown'],
  false, true
FROM categories c WHERE c.slug = 'accessories'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Merino Crewneck Sweater',
  'Lightweight merino wool crewneck in a relaxed fit. Perfect for layering or solo.',
  139.00,
  179.00,
  'https://images.pexels.com/photos/1300550/pexels-photo-1300550.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.7, 234,
  'Sale',
  ARRAY['XS','S','M','L','XL'],
  ARRAY['Oatmeal','Charcoal','Forest','Burgundy'],
  false, true
FROM categories c WHERE c.slug = 'casual-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Double-Breasted Suit',
  'A sharp double-breasted suit in an Italian wool blend. Contemporary tailoring for modern occasions.',
  449.00,
  NULL,
  'https://images.pexels.com/photos/842811/pexels-photo-842811.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.9, 38,
  'New',
  ARRAY['36','38','40','42','44'],
  ARRAY['Charcoal','Navy','Black'],
  false, true
FROM categories c WHERE c.slug = 'formal-wear'
ON CONFLICT DO NOTHING;

INSERT INTO products (name, description, price, original_price, image_url, category_id, rating, review_count, badge, sizes, colors, is_featured, in_stock)
SELECT
  'Quilted Puffer Vest',
  'Lightweight quilted vest with a matte nylon shell. Layer it for warmth without the bulk.',
  99.00,
  NULL,
  'https://images.pexels.com/photos/2526878/pexels-photo-2526878.jpeg?auto=compress&cs=tinysrgb&w=600',
  c.id,
  4.4, 145,
  NULL,
  ARRAY['XS','S','M','L','XL','XXL'],
  ARRAY['Olive','Black','Camel','Navy'],
  false, true
FROM categories c WHERE c.slug = 'outerwear'
ON CONFLICT DO NOTHING;
