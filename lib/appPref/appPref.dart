import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/alModels/vpn_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppPreferences {
  //static late SharedPreferences _prefs;

  static late Box boxOfData;
  // static Future<void> initPrefs() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }

  //get vpnInfo => null;
  static Future<void> initHive() async {
    await Hive.initFlutter();
    boxOfData = await Hive.openBox("data");
  }

  // SAVING USER CHOICE ABOUT THEME SELECTION
  static bool get isModeDark => boxOfData.get("isModeDark") ?? false;
  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);
  static VpnInfo get vpnInfoObj =>
      VpnInfo.fromJson(jsonDecode(boxOfData.get("vpn") ?? '{}'));
  static set vpnInfoobj(VpnInfo value) =>
      boxOfData.put("vpn", jsonEncode(value));
  static List<VpnInfo> get vpnList {
    List<VpnInfo> tempVpnList = [];
    final dataVpn = jsonDecode(boxOfData.get("vpnList") ?? '[]');
    for (var data in dataVpn) {
      tempVpnList.add(VpnInfo.fromJson(data));
    }
    return tempVpnList;
  }

  static set vpnList(List<VpnInfo> valueList) =>
      boxOfData.put("vpnList", jsonEncode(valueList));

  static isInitialPage() {}
}
