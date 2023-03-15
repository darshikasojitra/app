import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../bloc/block.dart';
import '../model/responses/cocktail_data.dart';

class CocktailProvider with ChangeNotifier {
  NetworkCubit? networkCubit;

  Future<CocktailData?> getcoctailData() async {
    Response? response;

    final uri = Uri.parse("${APIConstants.cocktailURL}/search.php")
        .replace(queryParameters: {'s': 'margarita'});
    response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      CocktailData usdata = CocktailData.fromJson(jsonDecode(response.body));
      return usdata;
    } else {}
    return null;
  }
}
