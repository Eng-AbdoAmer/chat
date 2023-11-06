class MessageModel {
  String? dateTime, receiverId, senderId, text;

  MessageModel({this.dateTime, this.receiverId, this.senderId, this.text});

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['sendrId'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      "dateTime": dateTime,
      "receiverId": receiverId,
      "sendrId": senderId,
      "text": text
    };
  }
}
