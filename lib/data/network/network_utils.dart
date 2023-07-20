import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/universal_data.dart';

UniversalData handleHttpErrors(http.Response response) {
  switch (response.statusCode) {
    case HttpStatus.badRequest:
      {
        return UniversalData(
          error: "Bad request exception",
        );
      }
    case HttpStatus.unauthorized:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
        );
      }
    case HttpStatus.forbidden:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
        );
      }
    case HttpStatus.notFound:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
        );
      }
    case HttpStatus.tooManyRequests:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
        );
      }
    case HttpStatus.internalServerError:
      {
        return UniversalData(
          error:
              "Error occurred while Communication with Server with StatusCode : ${response.statusCode}",
        );
      }
    case HttpStatus.notImplemented:
      {
        return UniversalData(
          error: "Server Error : ${response.statusCode}",
        );
      }
    default:
      return UniversalData(
        error: "Unknown Error occurred!",
      );
  }
}
