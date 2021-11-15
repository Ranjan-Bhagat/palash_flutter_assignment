import 'package:http/http.dart' as http;

import '/models/search_photo_model.dart';

class ApiService {
  static const String _baseURL = "https://api.pexels.com/v1";

  static const String _apiKey =
      '563492ad6f9170000100000105e6c9d2fac54610b916f96b178a5f35';

  static const Map<String, String> _authHeader = {'Authorization': _apiKey};

  static Future<dynamic> get(String url,
      {Map<String, String> headers = _authHeader}) async {
    Uri _url = Uri.parse(url);
    try {
      //Send http get request
      var res = await http.get(_url, headers: headers);
      return res;
    } catch (error) {
      // print("\nError : $error\n");
      return error.toString();
    }
  }

  static Future<dynamic> search(String query, {int perPage = 18,}) async {
    final url = '$_baseURL/search?query=$query&per_page=$perPage';
    var data = await get(url);
    if (data is http.Response) {
      return SearchPhotoModel.fromJson(data.body);
    } else {
      return data as String;
    }
  }

  static Future<dynamic> searchNextPage(String url) async {
    var data = await get(url);
    if (data is http.Response) {
      return SearchPhotoModel.fromJson(data.body);
    } else {
      return data as String;
    }
  }
}
