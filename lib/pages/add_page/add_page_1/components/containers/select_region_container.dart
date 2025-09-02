import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';
import '../bottom_sheets/region_bottom_sheet.dart';
import '../button/category_button.dart';
import '../button/dropdown_places.dart';

class SelectRegionContainer extends StatelessWidget {
  const SelectRegionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    return ExpandableNotifier(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 80,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(0, 3)
              )
            ]
        ),
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            hasIcon: false,
            tapBodyToExpand: false,
            tapBodyToCollapse: false,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '지역 · 카테고리',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Icon(
                      Icons.map_outlined,
                      size: 30,
                    ),
                  ],
                ),
                Obx(() =>
                    Row(
                      children: [
                            Text(
                            controller.selectedBigPlace.value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        ),
                            Text(
                            " · ${controller.selectedSmallPlace.value}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        ),
                        controller.selectedCategory.isNotEmpty
                            ? Expanded(
                              child: Row(
                                children: [
                                  Text(
                                      ' · ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.grey
                                    ),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                        children: _buildCategoryList(controller.selectedCategory),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ) : SizedBox.shrink(),
                      ],
                    ),
                )
              ],
            ),
          ),
          expanded: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                            '지역',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                RegionBottomSheet(),
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                              );
                              },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 87,
                              ),
                              height: 55,
                              decoration: BoxDecoration(
                                color: Color(0xFFE3E3E3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFFD9D9D9),
                                  width: 2,
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Obx(() =>
                                        Text(
                                          controller.selectedBigPlace.value,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )
                                    ),
                                    Icon(
                                        Icons.edit_outlined,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              width: 145,
                              height: 60,
                              child: DropdownPlaces(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '카테고리',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CategoryButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          collapsed: SizedBox.shrink(),
        ),
      ),
    );
  }
}

List<InlineSpan> _buildCategoryList(List<String> items) {
  List<InlineSpan> result = [];
  for (int i = 0; i < items.length; i++) {
    result.add(TextSpan(
        text: items[i],
    ));
    if (i != items.length - 1) {
      result.add(TextSpan(
          text: ' · ',
      ));
    }
  }
  return result;
}