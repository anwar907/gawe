import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mogawe/services/api_controller.dart';
import 'package:mogawe/services/url_list.dart';

class Profile extends GetxController with HiveObject {
  final ApiServiceController user = Get.put(ApiServiceController());
  String boxName = "Profile";

  var id = "".obs;
  var myCode = "".obs;
  var fullName = "".obs;
  var email = "".obs;
  var gender = "".obs;
  var scholl = "".obs;
  var level = "".obs;

  Profile();

  Profile.fromJson(Map<String, dynamic> json)
      : id = (json['id_mogawers'] ?? "").toString().obs,
        myCode = (json['mogawers_code'] ?? "").toString().obs,
        fullName = (json['full_name'] ?? "").toString().obs,
        email = (json['email'] ?? "").toString().obs,
        gender = (json['gender'] ?? "").toString().obs,
        scholl = (json['edu'] ?? "").toString().obs,
        level = (json['level'] ?? "").toString().obs;

  Future<String> userProfile() async {
    var profileBox = await Hive.openBox(boxName);
    var token = await user.getToken().then((value) => value);

    print("TOKEN NIH $token");
    var result;
    try {
      await http
          .get(
            UrlList.profile,
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(Duration(seconds: 20))
          .then((response) {
            Map responseMap = jsonDecode(response.body);
            print("RESPONSE DATA $responseMap");

            var _profile = Profile.fromJson(responseMap['user']);

            print("RESPONSE DATA $_profile");
            if (responseMap['message'] == "Berhasil") {
              user.setUserId(responseMap['user']['user_id']);

              print("RESPONSE DATA $responseMap");

              profileBox.put('id_mogawers', _profile.id.value);
              profileBox.put('mogawers_code', _profile.myCode.value);
              profileBox.put('full_name', _profile.fullName.value);
              profileBox.put('email', _profile.email.value);
              profileBox.put('gender', _profile.gender.value);
              profileBox.put('edu', _profile.scholl.value);
              profileBox.put('level', _profile.level.value);
            } else {
              result = responseMap['message'][0];
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

  Future<void> getMogaweId() async {
    var profileBox = await Hive.openBox(boxName);
    id.value = profileBox.get('id_mogawers');
  }

  Future<void> getMyCod() async {
    var profileBox = await Hive.openBox(boxName);
    myCode.value = profileBox.get('mogawers_code');
  }

  Future<void> getFullName() async {
    var profileBox = await Hive.openBox(boxName);
    fullName.value = profileBox.get('full_name');
  }

  Future<void> getEmail() async {
    var profileBox = await Hive.openBox(boxName);
    email.value = profileBox.get('email');
  }

  Future<void> getGender() async {
    var profileBox = await Hive.openBox(boxName);
    gender.value = profileBox.get('gender');
  }

  Future<void> getSchool() async {
    var profileBox = await Hive.openBox(boxName);
    scholl.value = profileBox.get('edu');
  }

  Future<void> getLevel() async {
    var profileBox = await Hive.openBox(boxName);
    level.value = profileBox.get('level');
  }
}
