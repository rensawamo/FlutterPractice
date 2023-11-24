import 'package:flutter/material.dart';

import 'package:udemyappfirst/data/dummy_data.dart';
import 'package:udemyappfirst/models/meal.dart';
import 'package:udemyappfirst/widgets/category_grid_item.dart';
import 'package:udemyappfirst/screens/meals.dart';
import 'package:udemyappfirst/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavorite;
  //  オブジェクトリストが必要
  final List<Meal> availableMeals;

//  navigation　を使う時は、 ここで navigationのページに　pageをpushするイメージです
// リスト化してからの
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        // どれがタップされたか category　IDで　判断するのか
        .where((meal) => meal.categories.contains(category.id))
        .toList();

//そしてその 下の 構造体の　の 要素に ナビゲーションのページを追加するのか

// class MealsScreen extends StatelessWidget {
//   const MealsScreen({
//     super.key,
//     required this.title,
//     required this.meals,
//     required this.onToggleFavorite,
//   });
// ⇧ 　の感じで　変数を要求
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        // for (final category in availableCategories)
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
