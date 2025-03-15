import 'package:buga/Provider/provider.dart';
import 'package:buga/constant/snackbar_view.dart';
import 'package:buga/screens/global_screens/emergency_cont.dart';
import 'search_export.dart';

class EmployeeSearch extends StatelessWidget {
  const EmployeeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      provider = ref;
      return Scaffold(
        backgroundColor: AppColors.lightYellow,
        body: SafeArea(
            child: Container(
          color: AppColors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: ListView(
            children: [
              SizedBox(height: 2.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        popScreen();
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
              SizedBox(height: 2.h),
              AuthWidgets.headerText('What organization do you work at?'),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'IWe would like to personalize your experience',
                  style: AppTextStyle.medium(
                    FontWeight.w500,
                    color: AppColors.gray,
                    fontSize: FontSize.font14,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              appLabel('Select from the options below'),
              SizedBox(height: 2.h),
              CategoryLayout.userSearch(),
              SizedBox(height: 1.h),
              SizedBox(
                  // color: Colors.red,
                  width: double.infinity,
                  height: 45.h,
                  child: CategoryLayout.categorySearchDisplay()),
              SizedBox(height: 4.h),
              MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                onPressed: () {
                  navigateTo(EmergencyContactForm());
                },
                color: AppColors.lightYellow,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed',
                        style: AppTextStyle.medium(
                          FontWeight.w700,
                          fontSize: FontSize.font18,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      Icon(Icons.arrow_circle_right_sharp)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}

class CategoryLayout {
  static final userInput = StateProvider((ref) => '');

  static Widget userSearch() {
    final TextEditingController controller = TextEditingController();
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.length > 3) {
          provider?.read(userInput.notifier).state = value;
          debugPrint(' User input its $value');
        } else {
          provider?.read(userInput.notifier).state = '';
        }
      },
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(
          Icons.search_rounded,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  static Widget categorySearchDisplay() {
    final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);

    return Consumer(builder: (context, ref, _) {
      provider = ref;
      final categoryList = ref.watch(CategorySearch.getCategoryListProvider);
      final getUserInput = ref.watch(userInput);
      final errorMessage = ref.watch(CategorySearch.searchUpdate);
      TextStyle textStyle = AppTextStyle.medium(
        FontWeight.w500,
        fontSize: FontSize.font14,
      );

      return categoryList.when(
        loading: () => Center(child: loadingAnimation()),
        error: (error, stackTrace) => Center(
            child: Text(
          'Error: $errorMessage',
          textAlign: TextAlign.center,
          style: AppTextStyle.medium(
            FontWeight.w700,
            fontSize: FontSize.font13,
          ),
        )),
        data: (data) {
          List<Map<String, dynamic>> filteredList = data.where((item) {
            final city = item['city']?.toLowerCase() ?? '';
            final state = item['state']?.toLowerCase() ?? '';
            final input = getUserInput.toLowerCase();
            return city.contains(input) || state.contains(input);
          }).toList();

          return ValueListenableBuilder<int?>(
              valueListenable: selectedIndexNotifier,
              builder: (context, selectedIndex, _) {
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return GestureDetector(
                      onTap: () {
                        debugPrint('ID its ::::: ${item['id']}');
                        // Update selected index and rebuild
                        selectedIndexNotifier.value = index;
                      },
                      child: Container(
                        color: selectedIndex == index
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          title: Text(item['city'] ?? 'City not available',
                              style: textStyle),
                          subtitle:
                              Text('State: ${item['state']}', style: textStyle),
                        ),
                      ),
                    );
                  },
                );
              });
        },
      );
    });
  }
}
