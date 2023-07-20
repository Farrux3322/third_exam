import 'dart:convert';
import 'dart:io';
import 'package:third_exam_n8/data/models/category_model/cotegory_model.dart';
import 'package:http/http.dart' as http;
import 'package:third_exam_n8/data/models/product_model/product_model.dart';
import '../models/universal_data.dart';
import 'network_utils.dart';

class ApiProvider {
  static Future<UniversalData> getAllProduct() async {
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/categories");

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        return UniversalData(
            data: (jsonDecode(response.body) as List?)
                    ?.map((e) => CategoryModel.fromJson(e))
                    .toList() ??
                []);
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet error");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (err) {
      return UniversalData(error: err.toString());
    }
  }

  static Future<UniversalData> getProductById(int id)async{
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/categories/$id");

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        return UniversalData(
            data: (jsonDecode(response.body) as List?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
                []);
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet error");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (err) {
      return UniversalData(error: err.toString());
    }
  }

  static Future<UniversalData> getProductAll()async{
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/products");

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        return UniversalData(
            data: (jsonDecode(response.body)["data"] as List?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
                []);
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet error");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (err) {
      return UniversalData(error: err.toString());
    }
  }

}
