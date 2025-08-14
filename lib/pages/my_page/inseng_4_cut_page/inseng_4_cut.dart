import 'package:conever/pages/my_page/photo_album/photo_display.dart';
import 'package:flutter/material.dart';

class Inseng4Cut extends StatelessWidget {
  const Inseng4Cut({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 43, 38, 0),
      child: Row(
        children: [
          Text(
            '동언님의 아카이브',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text(
              "4장",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}