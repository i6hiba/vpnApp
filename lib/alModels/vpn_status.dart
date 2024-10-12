class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? durationtTime;
  String? lastPacketReceive;

  VpnStatus({
    this.byteIn,
    this.byteOut,
    this.durationtTime,
    this.lastPacketReceive,
  });
  factory VpnStatus.fromJson(Map<String, dynamic> jsonData) => VpnStatus(
        byteIn: jsonData['byteIn'],
        byteOut: jsonData['byteOut'],
        durationtTime: jsonData['duration'],
        lastPacketReceive: jsonData['last_packet_raceive'],
      );

  Map<String, dynamic> toJson() => {
        'byte_in': byteIn,
        'byte_out': byteOut,
        'duration': durationtTime,
        'last_Packet_Receive': lastPacketReceive,
      };
}
