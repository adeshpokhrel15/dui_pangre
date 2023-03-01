import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class TopCategorySection extends StatefulWidget {
  const TopCategorySection({
    Key? key,
  }) : super(key: key);

  @override
  _TopCategorySectionState createState() => _TopCategorySectionState();
}

class _TopCategorySectionState extends State<TopCategorySection> {
  int _activeCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 36,
      ),
      child: SizedBox(
        height: 50.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryPhill(
              category: demoCategories[index],
              onTap: () {
                setState(() {
                  _activeCategory = demoCategories[index].id;
                });
              },
              isActive: _activeCategory == demoCategories[index].id,
            );
          },
          itemCount: demoCategories.length,
        ),
      ),
    );
  }
}

class CategoryPhill extends StatelessWidget {
  const CategoryPhill({
    Key? key,
    required this.onTap,
    required this.category,
    this.isActive = false, // by default active state is false
  }) : super(key: key);

  final GestureTapCallback onTap;
  final CategoryModel category;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 2.0,
        ),
        margin: const EdgeInsets.only(
          right: 10,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: isActive ? Colors.orange : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: const Offset(0, 1),
              blurRadius: 10,
            )
          ],
        ),
        child: Text(
          category.name,
          style: TextStyle(
            fontSize: 14,
            color: isActive ? Colors.blue : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
