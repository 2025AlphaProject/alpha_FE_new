import 'package:flutter/material.dart';

import '../../dio/authorized_dio.dart';

Future<int> registerTour(String title, DateTimeRange range) async {
  final dio = await getAuthorizedDio();
  final start = "${range.start.year}-${range.start.month.toString().padLeft(2, '0')}-${range.start.day.toString().padLeft(2, '0')}";
  final end = "${range.end.year}-${range.end.month.toString().padLeft(2, '0')}-${range.end.day.toString().padLeft(2, '0')}";

  final response = await dio.post(
    'http://3.34.125.36:80/tour/',
    data: {
      'tour_name': title,
      'start_date': start,
      'end_date': end,
    },
  );

  if (response.statusCode == 201) {
    return response.data['id'];  // TODO: 왜 response.data['id'] 를 반환해야 하는거지
  } else {
    throw Exception("RegisterTour not 201");
  }
}
