import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/alModels/ip_info.dart';
import 'package:flutter_application_3/alModels/network_ip_info.dart';
import 'package:flutter_application_3/alVpnGate/api_vpn_gate.dart';
import 'package:flutter_application_3/alWidgets/network_ip_info_widget.dart';
import 'package:get/get.dart';

class ConnectedNetworkIPInfoScreen extends StatelessWidget {
  const ConnectedNetworkIPInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipInfo = IpInfo.fromJson({}).obs;
    ApiVpnGate.retrieveIPDetails(IpInformation: ipInfo);


    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.redAccent,
      title: Text("Connected Network IP Information ", style: TextStyle(fontSize: 14),),
     ),
     floatingActionButton: Padding(
      padding: EdgeInsets.only(
       bottom: 10,
       right: 10

      ),
      child: FloatingActionButton(
      backgroundColor: Colors.redAccent,
      onPressed: (){
        ipInfo.value = IpInfo.fromJson({});
        ApiVpnGate.retrieveIPDetails(IpInformation: ipInfo);

      },
child: Icon(
  CupertinoIcons.refresh_circled,
   ),
      )
      ),
     body:Obx(()=> ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      children: [
        NetworkIPInfoWidget(networkIpInfo: NetworkIpInfo(titleText: 'IP Address', subTitle: ipInfo.value.query, iconData: Icon(Icons.my_location_outlined,color: Colors.redAccent,))),
        NetworkIPInfoWidget(networkIpInfo: NetworkIpInfo(titleText: 'Internet Service Provider', subTitle: ipInfo.value.internetSeviceProvider, iconData: Icon(Icons.account_tree,color: Colors.deepOrange,))),
        NetworkIPInfoWidget(networkIpInfo: NetworkIpInfo(titleText: 'Location', subTitle: ipInfo.value.countryName.isEmpty ? "Reterieving ..." : "${ipInfo.value.cityName},${ipInfo.value.regionName},${ipInfo.value.countryName}", iconData: Icon(CupertinoIcons.location_solid,color: Colors.green,))),
        NetworkIPInfoWidget(networkIpInfo: NetworkIpInfo(titleText: 'Zip Code', subTitle: ipInfo.value.zipCode, iconData: Icon(CupertinoIcons.map_pin_ellipse,color: Colors.purpleAccent,))),
        NetworkIPInfoWidget(networkIpInfo: NetworkIpInfo(titleText: 'Timezone', subTitle: ipInfo.value.timezone, iconData: Icon(Icons.share_arrival_time_outlined,color: Colors.cyan,))),

      ],
     )) ,
    );
  }
}
