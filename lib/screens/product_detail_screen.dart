import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

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

  Future<void> _openWhatsApp(BuildContext context) async {
    const phoneNumber = '6281234567890';

    final message =
        'Halo, saya ingin memesan ${product.name} '
        'dengan harga ${_formatPrice(product.finalPrice)}.';

    final whatsappUrl = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    try {
      final opened = await launchUrl(
        whatsappUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'WhatsApp tidak dapat dibuka.',
            ),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Terjadi masalah saat membuka WhatsApp.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 900,
                ),
                child: isWide
                    ? Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ProductImage(
                              product: product,
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: _ProductInformation(
                              product: product,
                              formattedPrice:
                                  _formatPrice(
                                product.finalPrice,
                              ),
                              originalPrice:
                                  _formatPrice(
                                product.price,
                              ),
                              onWhatsAppPressed: () {
                                _openWhatsApp(context);
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          _ProductImage(
                            product: product,
                          ),
                          const SizedBox(height: 24),
                          _ProductInformation(
                            product: product,
                            formattedPrice:
                                _formatPrice(
                              product.finalPrice,
                            ),
                            originalPrice:
                                _formatPrice(
                              product.price,
                            ),
                            onWhatsAppPressed: () {
                              _openWhatsApp(context);
                            },
                          ),
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

class _ProductImage extends StatelessWidget {
  final Product product;

  const _ProductImage({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.softCream,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.cake_rounded,
              size: 110,
              color: AppTheme.brown,
            ),
          ),

          if (product.discount != null)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  '-${product.discount!.percent}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductInformation extends StatelessWidget {
  final Product product;
  final String formattedPrice;
  final String originalPrice;
  final VoidCallback onWhatsAppPressed;

  const _ProductInformation({
    required this.product,
    required this.formattedPrice,
    required this.originalPrice,
    required this.onWhatsAppPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.category.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppTheme.brown,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          product.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),

        const SizedBox(height: 14),

        if (product.discount != null)
          Text(
            originalPrice,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              decoration:
                  TextDecoration.lineThrough,
            ),
          ),

        Text(
          formattedPrice,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.brown,
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          'Deskripsi Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          product.description,
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Colors.grey.shade800,
          ),
        ),

        const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onWhatsAppPressed,
            icon: const Icon(
              Icons.chat_outlined,
            ),
            label: const Text(
              'Pesan via WhatsApp',
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Pemesanan dan pembayaran dilakukan langsung melalui WhatsApp.',
          style: TextStyle(
            fontSize: 12,
            height: 1.4,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}