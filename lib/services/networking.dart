import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  final String url;
  NetworkService(this.url);

  Future getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
