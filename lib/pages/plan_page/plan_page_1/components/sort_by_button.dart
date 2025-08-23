import 'package:conever/controllers/plan_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// class SortByButton extends StatefulWidget {
//   final ValueChanged<List<Map<String, dynamic>>>? onSorted;
//
//   const SortByButton({
//     super.key,
//     this.onSorted,
//   });
//
//   @override
//   State<SortByButton> createState() => _SortByButtonState();
// }
//
// class _SortByButtonState extends State<SortByButton> {
//   final List<String> _options = ['날짜순','이름순'];
//   final List<Map<String, dynamic>> items = [
//     {
//       'title': '성북구 산책',
//       'date': '2025.08.16',
//       'tour_id': 1,
//     },
//     {
//       'title': '부산 바다',
//       'date': '2025.09.01',
//       'tour_id': 2,
//     },
//     {
//       'title': '제주 올레',
//       'date': '2025.10.12',
//       'tour_id': 3,
//     },
//   ];
//   String _selectedOption = '날짜순';
//
//   DateTime _parseDate(String s) {
//     final norm = s.contains('.') ? s.replaceAll('.', '-') : s;
//     return DateTime.parse(norm);
//   }
//
//   void _sortAndNotify(String criteria) {
//     final sorted = List<Map<String, dynamic>>.from(items);
//     if (criteria == '이름순' || criteria.toLowerCase().contains('name')) {
//       sorted.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));
//     } else if (criteria == '날짜순' || criteria.toLowerCase().contains('date')) {
//       sorted.sort((a, b) => _parseDate(a['date'] as String).compareTo(_parseDate(b['date'] as String)));
//     }
//     widget.onSorted?.call(sorted);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 130,
//       height: 30,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.white,
//       ),
//       child: DropdownButton<String>(
//         value: _selectedOption,
//         isExpanded: true,
//         icon: const Icon(Icons.arrow_drop_down,),
//         items: _options.map((option){
//           return DropdownMenuItem(
//             value: option,
//             child: Text(option)
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             _selectedOption = value!;
//             _sortAndNotify(_selectedOption);
//           });
//         },
//         underline: SizedBox(),
//       ),
//     );
//   }
// } //기준 버튼

class SortByButton extends StatelessWidget {
  final ValueChanged<String>? onOptionSelected;
  final List<String> _options = ['날짜순','이름순'];

  SortByButton({super.key, this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.find<PlanPageController>();
    return Obx(
      () => Container(
        width: width * 0.3,
        height: height * 0.032,
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: DropdownButton<String>(
          value: controller.sortCriteria.value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: _options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onOptionSelected?.call(value);
            }
          },
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
