class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });
}

List<CategoryModel> demoCategories = [
  CategoryModel(
    id: 1,
    name: 'Bike',
  ),
  CategoryModel(
    id: 2,
    name: 'Scooter',
  ),
  CategoryModel(
    id: 3,
    name: 'Electric ',
  ),
  CategoryModel(id: 4, name: 'Most Popular'),
];
