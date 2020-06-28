import 'package:flutter/widgets.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import '../services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  Status get status => _status;
  Status _status = Status.Unauthenticated;
  String isAuth;

  User user = User();

  String token;
  String name;
  String email;
  String password;

  UserProvider() {
    getUserToken();
    getUserName();
    getEmail();
  }
  Future<bool> loginUser(String email, password) async {

    final result = await Webservice().login(email, password);
    _status=Status.Authenticating;
    this.user = result;
    this.name = user.userDetails.name;
    this.email = user.userDetails.email;
    this.token = user.accessToken;

    await setUserToken();

    //todo network validation


    _status = Status.Authenticated;

    print("login success");

    notifyListeners();
  }

  Future<User> changePassword(
      String old_password, new_password, confirm_new_password) async {
    final result = await Webservice().changePassword(old_password, new_password, confirm_new_password);

    print("Password change success");
    print(result);
    notifyListeners();
  }



  setUserToken() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString("name", user.userDetails.name);
    await sharedPreferences.setString("token", user.accessToken);



    await sharedPreferences.setString("email", user.userDetails.email);

    notifyListeners();
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.token = await prefs.getString("token");
    if (token == null) {
      _status = Status.Unauthenticated;
    } else {
      _status = Status.Authenticated;
    }
    notifyListeners();
    return this.token;
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.name = await prefs.getString("name" ?? '');

    notifyListeners();

    return this.name;
  }

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.email = await prefs.getString("email" ?? '');

    return email;
  }

  deleteUserToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    _status = Status.Unauthenticated;
    print('tokendeleted');
    notifyListeners();
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      notifyListeners();
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      notifyListeners();
      return "Invalid Email";
    } else {
      notifyListeners();
      return null;
    }
  }

  Future signOut() async {
    deleteUserToken();

    notifyListeners();
    return Future.delayed(Duration.zero); // need for type return
  }
}
