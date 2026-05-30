import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../mock/mock_data.dart';
import 'section_header.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = MockData.blogPosts;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.sectionPadding,
        horizontal: 24,
      ),
      color: AppColors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          int crossAxisCount;
          if (width > 900) {
            crossAxisCount = 3;
          } else if (width > 600) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 1;
          }

          return Column(
            children: [
              SectionHeader(
                title: 'OUR BLOG',
                hasDashes: true,
              ),
              const SizedBox(height: 40),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.85,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return _BlogCard(post: post);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, String> post;

  const _BlogCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Image.network(
                  post['imageUrl'] ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: AppColors.surface,
                    child: Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey[300]),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.badgeNew,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      post['category'] ?? '',
                      style: AppTextStyles.badge.copyWith(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'] ?? '',
                  style: AppTextStyles.blogTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'By ${post['author'] ?? ''}',
                  style: AppTextStyles.blogAuthor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
