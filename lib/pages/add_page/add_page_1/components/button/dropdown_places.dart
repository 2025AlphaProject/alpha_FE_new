import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';

class DropdownPlaces extends StatelessWidget {
  const DropdownPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    return Obx(() => controller.isAreaCodeLoading.value
        ? Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black,
            width: 1,
          )
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.5),
            child: Text('로딩중...'),
          ),
        ],
      ),
    )
        : DropdownSearch<String>(
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
          backgroundColor: Colors.white,
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "검색...",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        itemBuilder: (context, item, isSelected) => Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.white,
          ),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ),
        fit: FlexFit.loose,
        constraints: BoxConstraints(
          maxHeight: 250,
        ),
        scrollbarProps: ScrollbarProps(
          thumbVisibility: true,
        ),
      ),
      items: controller.areaListName,
      selectedItem: controller.areaListName[0],
      onChanged: (value) {
        final controller = Get.find<AddPageController>();
        controller.selectedSmallPlace.value = value!;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    ));
  }
}
