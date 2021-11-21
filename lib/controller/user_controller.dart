import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:read_on/model/user_login_model.dart';

class UserController extends GetxController {
  final String _accept = 'application/json';
  final String _contentType = 'application/x-www-form-urlencoded';
  final String _authorization = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9yZWFkb24uZ2xhbXdvcmxkaXRsdGQuY29tXC9hcGlcL2F1dGhcL3JlZ2lzdGVyIiwiaWF0IjoxNjM3MDQxMjc3LCJleHAiOjE2MzcwNDQ4NzcsIm5iZiI6MTYzNzA0MTI3NywianRpIjoiWVdPZDRrQkZCQmllRkI4ZSIsInN1YiI6MywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.izViNjeDN42xVJmxjs6DjxfmBk-m7de5Ej3y6zwuQ0M';

  Future<bool> registerUser(Map userData) async {
    try {
      var response = await http.post(
          Uri.parse('http://readon.glamworlditltd.com/api/auth/register'),
          headers: {
            'Accept': _accept,
            'Content-Type': _contentType
          },
          body: userData
      );
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Successfully registered! status code = ${response.statusCode}');
        return true;
      } else {
        // ignore: avoid_print
        print('Registration failed! status code = ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // ignore: avoid_print
      print('Registration of user failed: $error');
      return false;
    }
  }

  Future<UserLoginModel?>login(Map data) async {
    try{
      var response = await http.post(
          Uri.parse('http://readon.glamworlditltd.com/api/auth/login'),
          headers: {
            'Accept': _accept,
            'Content-Type': _contentType,
            'Authorization' : _authorization
          },
          body: data
      );
      String responseString = response.body;
      return userLoginModelFromJson(responseString);
    }catch(error){
     return null;
    }
  }
}
