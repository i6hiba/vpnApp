import 'package:flutter_application_3/alModels/vpn_info.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

//part 'vpn_info_adapter.g.dart'; // Generate this file using Hive's generator

@HiveType(typeId: 0) // Choose a unique typeId for your adapter
class VpnInfoAdapter extends TypeAdapter<VpnInfo> {
  @override
  final int typeId = 0; // Same typeId as above

  @override
  VpnInfo read(BinaryReader reader) {
    final jsonData = <String, dynamic>{};
    reader.readMap().forEach((key, value) {
      jsonData[key] = value;
    });
    return VpnInfo.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, VpnInfo obj) {
    final jsonData = obj.toJson();
    writer.writeMap(jsonData);
  }
}