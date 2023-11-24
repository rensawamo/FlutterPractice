import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:udemyappfirst/models/meal.dart';

// ほぼviewModelのファイル

// これはSwiftUIのObservableObject に似ている。

// StateNotifier<List<Meal>>  リストの状態管理を示す
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // observalobjecetの .init()
  FavoriteMealsNotifier() : super([]);

// -> でなく 先頭に 何を返すか定義できるのか
  bool toggleMealFavoriteStatus(Meal meal) {
    // 状態管理の widget のStateNotifierのプロパティ的な感じ
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// １、　ObservalObjectを作って
// 2、　　finalでインスタンス化して　高速でアクセスできるように
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
