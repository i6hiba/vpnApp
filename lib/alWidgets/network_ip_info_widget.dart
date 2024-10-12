import 'package:flutter/material.dart';
import 'package:flutter_application_3/alModels/network_ip_info.dart';
import 'package:flutter_application_3/main.dart';

class NetworkIPInfoWidget extends StatelessWidget {
  final NetworkIpInfo networkIpInfo;

  const NetworkIPInfoWidget({super.key , required this.networkIpInfo});

  @override
  Widget build(BuildContext context) {
    sizeScreen= MediaQuery.of(context).size;
    return Card
    (

      elevation: 6,
      margin: EdgeInsets.symmetric(vertical:sizeScreen.height*.01 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Icon(
        networkIpInfo.iconData.icon,
        size: networkIpInfo.iconData.size??28,

      ),
      title: Text(
        networkIpInfo.titleText,
      ),
      subtitle: Text(
        networkIpInfo.subTitle,
      ),
      ),

    );
  }
}
