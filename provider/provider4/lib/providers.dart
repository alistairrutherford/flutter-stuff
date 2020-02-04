
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:provider4/user.dart';
import 'package:provider4/users.dart';

class UserProvider {
  static const WAIT = 2;

  // Don't forget to define this in yml file with tabbed indent.
  final String _dataPath = "assets/data/users.json";
  List<User> users;
 
  Future<List<User>> loadUserData( ) async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = Users.fromJson(dataString).users;
    print('done loading user!' + jsonEncode(users));
    return users;
  }
 
  Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: WAIT), () async {
    String data = await rootBundle.loadString(_dataPath);
    return data;
    });
  }
  
}