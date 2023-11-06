import 'package:chat/core/constant/images_assets.dart';

class OnBoardingModel {
  final String imageUrl, title, description;

  OnBoardingModel(
      {required this.imageUrl, required this.title, required this.description});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      imageUrl: AppImagesAssets.board1,
      title: 'on Boarding one',
      description:
          'It connects you at random to other curious web surfers throughout the world for voice, video or text chat.'),
  OnBoardingModel(
      imageUrl: AppImagesAssets.board2,
      title: 'on Boarding two',
      description:
          'The customer can either speak through microphone and speakers or headset, text chat, or use a conventional telephone to communicate with the operator'),
  OnBoardingModel(
      imageUrl: AppImagesAssets.board3,
      title: 'on Boarding three',
      description:
          'Some virtual tabletops include text chat in addition to map and image sharing, campaign management and more.'),
];
