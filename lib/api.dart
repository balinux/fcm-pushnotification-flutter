import 'dart:async';
import 'dart:convert';
import 'package:androidx_flutter_dev/set_token_model.dart';
import 'package:androidx_flutter_dev/user_.dart';
import 'package:http/http.dart' show Client;

class Api {
  Client client = Client();

  Future<SetToken> setTokenToServer(int idSSO, String token) async {
    print('triggered');
    final response = await client.get(
        "https://66237f03.ngrok.io/api/v1/set-token/" +
            idSSO.toString() +
            "/" +
            token,
        headers: {
          "Accept": "application/json",
        });
    print(response);
    if (response.statusCode == 200) {
      return SetToken.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<User> getUser() async {
    print('triggered');
    final response = await client
        .get("https://jsonplaceholder.typicode.com/todos/1", headers: {
      "Accept": "application/json",
    });
    print(response);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
