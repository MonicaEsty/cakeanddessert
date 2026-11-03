import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import 'admin_login_screen.dart';
import 'catalog_screen.dart';
import 'product_detail_screen.dart';
import 'promo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatPrice(double price) {
    final value = price.toStringAsFixed(0);
    final result = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      if (i > 0 && (value.length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(value[i]);
    }

    return 'Rp$result';
  }

  int _getColumnCount(double width) {
    if (width >= 900) {
      return 3;
    }

    if (width >= 600) {
      return 2;
    }

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final featuredProducts = dummyProducts
        .where((product) => product.isFeatured)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MILKY Bakery'),
        actions: [
          IconButton(
            tooltip: 'Admin',
            icon: const Icon(
              Icons.admin_panel_settings_outlined,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminLoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnCount = _getColumnCount(
            constraints.maxWidth,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroSection(
                      onCatalogPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CatalogScreen(),
                          ),
                        );
                      },
                      onPromoPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PromoScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Produk Unggulan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Pilihan favorit untuk menemani momen spesialmu.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: featuredProducts.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio:
                            columnCount == 1 ? 2.4 : 1.45,
                      ),
                      itemBuilder: (context, index) {
                        final product =
                            featuredProducts[index];

                        return _ProductCard(
                          product: product,
                          price: _formatPrice(
                            product.finalPrice,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onCatalogPressed;
  final VoidCallback onPromoPressed;

  const _HeroSection({
    required this.onCatalogPressed,
    required this.onPromoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.softCream,
        borderRadius: BorderRadius.circular(24),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 650;

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sweet Moments\nStart Here',
                style: TextStyle(
                  fontSize: 32,
                  height: 1.15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Temukan cake dan dessert pilihan '
                'untuk membuat setiap momen terasa lebih manis.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.grey.shade800,
                ),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  ElevatedButton.icon(
                    onPressed: onCatalogPressed,
                    icon: const Icon(
                      Icons.cake_outlined,
                    ),
                    label: const Text(
                      'Lihat Katalog',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: onPromoPressed,
                    icon: const Icon(
                      Icons.local_offer_outlined,
                    ),
                    label: const Text(
                      'Lihat Promo',
                    ),
                  ),
                ],
              ),
            ],
          );

          if (!isWide) {
            return content;
          }

          return Row(
            children: [
              Expanded(
                flex: 3,
                child: content,
              ),
              const SizedBox(width: 32),
              const Expanded(
                flex: 2,
                child: Icon(
                  Icons.cake_rounded,
                  size: 150,
                  color: AppTheme.brown,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final String price;
  final VoidCallback onTap;

  const _ProductCard({
    required this.product,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 86,
                height: double.infinity,
                constraints: const BoxConstraints(
                  maxHeight: 110,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.softCream,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.cake_outlined,
                  size: 44,
                  color: AppTheme.brown,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      product.category.name,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.brown,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: AppTheme.brown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}