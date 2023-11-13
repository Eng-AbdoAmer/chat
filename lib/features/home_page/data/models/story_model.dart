import 'package:flutter/material.dart';

enum MediaType {
  image("image"),
  text("text");

  final String name;
  const MediaType(this.name);
}

// extension TitleMediaType on MediaType {
//   String Name() {
//     switch (this) {
//       case MediaType.image:
//         return "image";
//       case MediaType.text:
//         return "text";
//     }
//   }
// }

class StoryModel {
 late String mediaType;
  late String senderEmail;
  String? imageUrl;
  String? title;
  String? caption;

  StoryModel({
    this.title,
    this.imageUrl,
     required this.mediaType,
    this.caption,
    required this.senderEmail,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    senderEmail = json['senderEmail'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    return {
      "mediaType": mediaType,
      "imageUrl": imageUrl,
      "title": title,
      "senderEmail": senderEmail,
      "caption": caption
    };
  }
}
