import '../models/category.dart';
import '../models/discount.dart';
import '../models/product.dart';

const cakeCategory = Category(
  id: 1,
  name: 'Cake',
);

const dessertCategory = Category(
  id: 2,
  name: 'Dessert',
);

final promoWeekend = Discount(
  id: 1,
  title: 'Weekend Sweet Deal',
  description: 'Diskon spesial untuk beberapa produk pilihan.',
  percent: 10,
  bannerImage: 'assets/images/promo_weekend.jpg',
  startDate: DateTime(2026, 10, 1),
  endDate: DateTime(2026, 12, 31),
  status: 'published',
);

final List<Product> dummyProducts = [
  Product(
    id: 1,
    name: 'Chocolate Cake',
    slug: 'chocolate-cake',
    description: 'Cake cokelat lembut dengan rasa manis dan tekstur moist.',
    price: 150000,
    image: 'assets/images/chocolate_cake.jpg',
    isFeatured: true,
    category: cakeCategory,
    discount: promoWeekend,
  ),
  Product(
    id: 2,
    name: 'Cheesecake',
    slug: 'cheesecake',
    description: 'Cheesecake lembut dengan rasa creamy dan sedikit gurih.',
    price: 120000,
    image: 'assets/images/cheesecake.jpg',
    isFeatured: true,
    category: cakeCategory,
  ),
  Product(
    id: 3,
    name: 'Tiramisu',
    slug: 'tiramisu',
    description: 'Dessert berlapis dengan perpaduan kopi dan krim.',
    price: 85000,
    image: 'assets/images/tiramisu.jpg',
    isFeatured: false,
    category: dessertCategory,
    discount: promoWeekend,
  ),
];