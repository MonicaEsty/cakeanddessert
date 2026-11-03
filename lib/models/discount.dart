class Discount {
  final int id;
  final String title;
  final String description;
  final int percent;
  final String bannerImage;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  const Discount({
    required this.id,
    required this.title,
    required this.description,
    required this.percent,
    required this.bannerImage,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
}