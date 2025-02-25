import 'package:hive/hive.dart';

part 'rating.g.dart';

@HiveType(typeId: 12)
class Rating extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int rating;

  @HiveField(2)
  List<String> improvements;

  @HiveField(3)
  String review;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  DateTime createdAt;

  Rating({
    required this.id,
    required this.rating,
    required this.improvements,
    required this.review,
    this.imagePath,
    required this.createdAt,
  });
}
