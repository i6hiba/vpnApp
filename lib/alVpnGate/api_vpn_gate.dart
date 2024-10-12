import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter_application_3/alModels/ip_info.dart';
import 'package:flutter_application_3/appPref/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_3/alModels/vpn_info.dart';
import 'package:get/get.dart';

class ApiVpnGate {
  static Future<List<VpnInfo>> retrieveAllAvailableFreeVpnServers() async {
    final List<VpnInfo> vpnServerList = [];
    try {
      final respondFromApi =
          await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      final commaSeparatedValueString =
          respondFromApi.body.split("#")[1].replaceAll("*", "");

      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSeparatedValueString);

      final header = listData[0];
      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};
        for (int innercounter = 0;
            innercounter < header.length;
            innercounter++) {
          jsonData.addAll({
            header[innercounter].toString(): listData[counter][innercounter]
          });
        }
        vpnServerList.add(VpnInfo.fromJson(jsonData));
      }
    } catch (errorMsg) {
      Get.snackbar("Error Occurred", errorMsg.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(.8));
    }
    vpnServerList.shuffle();
    if (vpnServerList.isNotEmpty) AppPreferences.vpnList = vpnServerList;
    return vpnServerList;
  }

  static Future<void> retrieveIPDetails(
      {required Rx<IpInfo> IpInformation}) async {
    try {
      final responseFromApi =
          await http.get(Uri.parse('http://ip-api.com/json/'));
      final dataFromApi = jsonDecode(responseFromApi.body);

       IpInformation.value = IpInfo.fromJson(dataFromApi);
    } catch (errorMsg) {
      Get.snackbar("Error Occurred", errorMsg.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(.8));
    }
  }
}
