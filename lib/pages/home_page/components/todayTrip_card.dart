import 'package:flutter/material.dart';

class TodayTripCard extends StatelessWidget {
  const TodayTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.04,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFCCCCCC)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [_buildTag("음식점"), _buildTag("스포츠"), _buildTag("숙박")],
          ),
          SizedBox(height: size.height * 0.012),
          Text(
            '태그니의 아산 여행',
            style: TextStyle(
              fontSize: size.width * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF9A9A9A)),
              const SizedBox(width: 4),
              Text(
                '충남 아산',
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: Color(0xFF707070),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF9A9A9A),
              ),
              const SizedBox(width: 4),
              Text(
                '2025.08.15(금)',
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: Color(0xFF707070),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.person, size: 16, color: Color(0xFF9A9A9A)),
              const SizedBox(width: 4),
              Text(
                '1명',
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: Color(0xFF707070),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.06),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '50%',
                style: TextStyle(
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text('5 / 10', style: TextStyle(fontSize: size.width * 0.035)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Color(0xFFEF3F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
