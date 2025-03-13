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









  // @override
// Widget build(BuildContext context) {
//   final categoryList = ref.watch(CategorySearch.getCategoryListProvider);

//   return Scaffold(
//     appBar: AppBar(title: Text('Category List')),
    // body: categoryList.when(
    //   loading: () => Center(child: CircularProgressIndicator()),
    //   error: (error, stackTrace) => Center(child: Text('Error: ${error.toString()}')),
    //   data: (data) => ListView.builder(
    //     itemCount: data.length,
    //     itemBuilder: (context, index) {
    //       final item = data[index];
    //       return ListTile(
    //         title: Text(item['city'] ?? 'City not available'),
    //         subtitle: Text('State: ${item['state']}, ID: ${item['id']}'),
    //       );
    //     },
    //   ),
    // ),
//   );
// }
