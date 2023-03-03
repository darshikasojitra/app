import 'dart:convert';
import 'dart:io';
import 'package:demo_splash_screen/bloc/block.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:demo_splash_screen/model/model.dart';
import 'package:http/http.dart';

class UsDataProvider with ChangeNotifier {
  NetworkCubit? networkCubit;

  Future<UsDataResponse?> getUsData() async {
    Response? response;

    final uri = Uri.parse("${APIConstants.baseURL}/data").replace(
        queryParameters: {'drilldowns': 'Nation', 'measures': 'Population'});
    response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      UsDataResponse usdata =
          UsDataResponse.fromJson(jsonDecode(response.body));
      return usdata;
    } else {}
    return null;
  }
}
