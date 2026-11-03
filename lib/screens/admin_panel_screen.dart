import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
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

  void _deleteProduct(Product product) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Produk'),
          content: Text(
            'Yakin ingin menghapus ${product.name} dari data lokal?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  dummyProducts.remove(product);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${product.name} berhasil dihapus.',
                    ),
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final promoProducts = dummyProducts
        .where((product) => product.discount != null)
        .toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                    const Text(
                      'Dashboard Admin',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Kelola data produk dan promo sementara untuk Gate 1.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 24),

                    LayoutBuilder(
                      builder: (context, summaryConstraints) {
                        final isWide =
                            summaryConstraints.maxWidth >= 600;

                        final cards = [
                          Expanded(
                            child: _SummaryCard(
                              title: 'Total Produk',
                              value: dummyProducts.length.toString(),
                              icon: Icons.cake_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _SummaryCard(
                              title: 'Produk Promo',
                              value: promoProducts.length.toString(),
                              icon: Icons.local_offer_outlined,
                            ),
                          ),
                        ];

                        if (isWide) {
                          return Row(
                            children: cards,
                          );
                        }

                        return Column(
                          children: [
                            _SummaryCard(
                              title: 'Total Produk',
                              value: dummyProducts.length.toString(),
                              icon: Icons.cake_outlined,
                            ),
                            const SizedBox(height: 12),
                            _SummaryCard(
                              title: 'Produk Promo',
                              value: promoProducts.length.toString(),
                              icon: Icons.local_offer_outlined,
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Kelola Produk',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (dummyProducts.isEmpty)
                      const _EmptyState(
                        icon: Icons.inventory_2_outlined,
                        text: 'Belum ada produk.',
                      )
                    else
                      ...dummyProducts.map(
                        (product) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: Card(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(12),
                              leading: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppTheme.softCream,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.cake_outlined,
                                  color: AppTheme.brown,
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4),
                                child: Text(
                                  '${product.category.name} • '
                                  '${_formatPrice(product.finalPrice)}',
                                ),
                              ),
                              trailing: IconButton(
                                tooltip: 'Hapus produk',
                                onPressed: () {
                                  _deleteProduct(product);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    const Text(
                      'Promo Aktif',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (promoProducts.isEmpty)
                      const _EmptyState(
                        icon: Icons.local_offer_outlined,
                        text: 'Belum ada produk promo.',
                      )
                    else
                      ...promoProducts.map(
                        (product) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12),
                          child: Card(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(12),
                              leading: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppTheme.softCream,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_offer_outlined,
                                  color: AppTheme.brown,
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Diskon ${product.discount!.percent}%',
                              ),
                            ),
                          ),
                        ),
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppTheme.softCream,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppTheme.brown,
              ),
            ),

            const SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EmptyState({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.brown,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}