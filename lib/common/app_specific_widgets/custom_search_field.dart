import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key,

    required this.onSearch,
    required this.onSearchTap,
    required this.onSearchFocusChange,
    required this.isSearchValid,
    required this.isSearchTapped,
    required this.searchController,
    required this.hintText,
    required this.isNotHome,
    this.filterTap,
  });


  final ValueChanged<String> onSearch;
  final VoidCallback onSearchTap;
  final VoidCallback onSearchFocusChange;
  final bool isSearchValid;
  final bool isSearchTapped;
  final TextEditingController searchController;
  final String hintText;
  final bool isNotHome;
  final VoidCallback? filterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          //horizontal: 24.w,
          vertical: 22.h),
      height: 100.h,
      width: 390.w,
    //  color: Color(0xffDBDBDB).withOpacity(0.4),// Adjust the height as needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Card(

              elevation: 1,
              color: Color(0xffFEFDED),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: isNotHome
                    ? CommonFunctions.deviceWidth(context) * 0.89
                    : CommonFunctions.deviceWidth(context) * 0.76,
                // Adjust the width as needed

                child: TextField(
                  controller: searchController,
                  onChanged: onSearch,
                  // onTap: onSearchTap,
                  // focusNode: FocusNode()..addListener(onSearchFocusChange),
                  /* onFieldSubmitted: (value) {
                    if (isSearchValid) {
                      onSearch(value);
                    }
                  },*/
                  onSubmitted: (value){
                    if (isSearchValid) {
                      onSearch(value);

                    }
                    FocusScope.of(context).unfocus();
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 9.w),
                    hintText: hintText,
                    hintStyle: const TextStyle(fontSize: 14),
                    errorText: !isSearchValid && isSearchTapped
                        ? 'Input is invalid'
                        : null,
                    border: InputBorder.none,
                    /*   OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),*/
                    enabledBorder:InputBorder.none,
                    /*OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),*/
                    focusedBorder: InputBorder.none,
                    /*OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),*/
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 4, top: 8, right: 0, bottom: 8),
                      child: Image.asset(
                        Drawables.searchTextFieldIcon,
                        fit: BoxFit.contain,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          isNotHome ? const SizedBox.shrink() : const SizedBox(width: 10),
          isNotHome
              ? const SizedBox.shrink()
              : GestureDetector(
            onTap: filterTap,
            child: Container(

              decoration: BoxDecoration(
                  color: Color(0xffFEFDED),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Drawables.searchFilterIcon,
              ),
            ),
          ),

        ],
      ),
    );
  }
}