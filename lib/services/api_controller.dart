import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mogawe/services/url_list.dart';

class ApiServiceController extends GetxController with HiveObject {
  String boxName = 'user';
  var userId = 0.obs;

  Future<String> getEntry() async {
    var box = await Hive.openBox(boxName);
    return box.get("entry");
  }

  Future<void> setEntry(String entry) async {
    var box = await Hive.openBox(boxName);
    box.put("entry", entry);
  }

  Future<int> getUserId() async {
    var box = await Hive.openBox(boxName);
    return box.get("userId");
  }

  Future<void> setUserId(int idUser) async {
    var box = await Hive.openBox(boxName);
    userId.value = idUser;
    box.put("userId", idUser);
  }

  Future<String> getToken() async {
    var box = await Hive.openBox(boxName);
    return box.get('token');
  }

  Future<void> setToken(String token) async {
    var box = await Hive.openBox(boxName);
    box.put('token', token);
  }

  Future<String> loginUser(String email, String password) async {
    var fetchData;
    String result;
    try {
      await http
          .post(UrlList.login, body: {
            "email": email,
            "password": password,
          })
          .timeout(Duration(seconds: 20))
          .then((value) {
            fetchData = jsonDecode(value.body);
            if (fetchData['message'] == "Berhasil") {
              setToken(fetchData['token']);
              print("BERHASIL LOGIN $fetchData");
            }
            if (fetchData.containsKey('password')) {
              result = fetchData['password'][0];
            }
            if (fetchData.containsKey('message')) {
              result = fetchData["message"][0];
            }
          });
    } on TimeoutException catch (_) {
      result = "No respond after 20 seconds";
    } catch (e) {
      print(e);
      result = "Failed to fetch API";
    }
    return result;
  }
}
