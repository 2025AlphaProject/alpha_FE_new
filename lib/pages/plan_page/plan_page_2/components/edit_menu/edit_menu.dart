import 'package:flutter/material.dart';
import 'package:get/get.dart';
import'edit_function.dart';

class EditMenuSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      padding: EdgeInsets.all(width*0.05),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('편집', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 16),
            _editItem('여행 장소 삭제',()=>EditFunction().deletePlaces(),0xFF000000),
            _editItem('여행 제목 수정',()=>EditFunction().renameTour(context),0xFF000000),
            _editItem('여행 날짜 수정',()=>EditFunction().changeDate(context),0xFF000000),
            _editItem('여행 삭제',()=>EditFunction().deleteTour(context),0xFFD3351E),
          ],
        ),
      ),
    );
  }

  Widget _editItem(String text,VoidCallback edit, int color) {
    return GestureDetector(
      onTap: edit,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(text, style: TextStyle(fontSize: 16,color:Color(color) ),),
      ),
    );
  }
}


