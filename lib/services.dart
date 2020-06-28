import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/user_model.dart';

const String url = 'url of api' ;

class Webservice {
  var token;
  User user = User();


  Future<User> login(String email, password) async {
    Map userdata = {'email': email, 'password': password};
    final response = await http
        .post('$url/login', body: userdata);

    if (response.statusCode == 200) {

      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }



  Future<User> changePassword(String old_password, new_password, confirm_new_password) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    Map resetPasswordData = {
      'old_password': old_password,
      'new_password': new_password,
      'confirm_new_password': confirm_new_password
    };
    final response = await http.post(
      '$url/user/changePassword',
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: resetPasswordData,
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to change Password');
    }
  }


}
