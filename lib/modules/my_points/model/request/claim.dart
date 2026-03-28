import 'dart:convert';

class ClaimData{
  late int campaignId;

  ClaimData({
    this.campaignId=-1,
  });

  Map<String, dynamic> toJson() => {
    "campaign_id": campaignId,
  };

  String parse(){
    return jsonEncode(toJson());
  }
}