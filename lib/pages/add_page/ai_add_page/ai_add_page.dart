import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_page_controller.dart';
import 'components/buttons/ai_add_page_bottom_button.dart';
import 'components/container/build_tour_list.dart';

class AiAddPage extends StatefulWidget {
  const AiAddPage({super.key});

  @override
  State<AiAddPage> createState() => _AiAddPageState();
}

class _AiAddPageState extends State<AiAddPage> {
  final controller = Get.find<AddPageController>();

  @override
  void initState() {
    super.initState();
    controller.fetchAITour();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 34, 9, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                    'AI 추천 장소 선택',
                  style: TextStyle(
                      fontSize: width * 0.082,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                  "${controller.selectedBigPlace} ${
                      controller.selectedSmallPlace.value != "선택 X"
                      ? controller.selectedSmallPlace
                      : ""
                  }",
                  style: TextStyle(
                    color: Colors.grey ,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey
                      ),
                      children: _buildCategoryList(controller.selectedCategory),
                    ),
                  ),
                ),
              ),
              BuildTourList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: AiAddPageBottomButton()
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
      style: TextStyle(
        color: Color(0xFFD3351E),
        fontWeight: FontWeight.bold,
      )
    ));
    if (i != items.length - 1) {
      result.add(TextSpan(
        text: ', ',
      ));
    }
  }
  return result;
}