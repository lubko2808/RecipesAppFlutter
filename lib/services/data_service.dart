import 'package:recipes_app_flutter/models/recipe.dart';
import 'package:recipes_app_flutter/services/http_service.dart';

class DataService {

  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes(String filter) async {
    var path = "/recipes";
    if (filter.isNotEmpty) {
      path += "/meal-type/$filter";
    }
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      return recipes;
    } else {
      return null;
    }
  }

}