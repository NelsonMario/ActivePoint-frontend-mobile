import 'dart:convert';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/user.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserHttp{
  final String getUserUrl = Endpoints.getUserUrl;

  Future<User> getUser(String email, String password, String token) async {
    Response res = await get(getUserUrl, headers: {
      'Authorization': 'Bearer ' + token
    });
    print(res.statusCode);
    if(res.statusCode == 200){
      var user = jsonDecode(res.body);
      return User.fromJson(user);
    }else{
      return null;
    }
  }

  Future<User> getUserFromSF() async {

    TokenHttp tokenHttp = new TokenHttp();
    String token = await tokenHttp.readToken();

    Response res = await get(getUserUrl, headers: {
      'Authorization': 'Bearer ' + token
    });

    if(res.statusCode == 200){
      var user = jsonDecode(res.body);
      print(user);
      return User.fromJson(user);
    }else{
      return null;
    }
  }

}