import 'category.dart';
import 'discount.dart';

class Product {
  final int id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final String image;
  final bool isFeatured;
  final Category category;
  final Discount? discount;

  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.image,
    required this.isFeatured,
    required this.category,
    this.discount,
  });

  double get finalPrice {
    if (discount != null) {
      return price * (100 - discount!.percent) / 100;
    }

    return price;
  }
}