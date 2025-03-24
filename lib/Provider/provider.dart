import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySearch {
  static final searchUpdate = StateProvider((ref) => '');

  static final getCategoryListProvider = StateNotifierProvider<
      CategoryListNotifier, AsyncValue<List<Map<String, dynamic>>>>((ref) {
    return CategoryListNotifier();
  });
}

// Create a StateNotifier class to manage the state of the search
class CategoryListNotifier
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  CategoryListNotifier() : super(const AsyncValue.loading());

  // Method to update the data
  void updateCategoryList(List<Map<String, dynamic>> categoryList) {
    state = AsyncValue.data(categoryList);
  }
}

