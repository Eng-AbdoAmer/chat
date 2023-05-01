import 'package:chat/core/classes/status_request.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/images_assets.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child:
                Image.asset(AppImagesAssets.loading, height: 300, width: 250))
        : statusRequest == StatusRequest.offline
            ? Center(child: Lottie.asset(AppImagesAssets.noInternet))
            : statusRequest == StatusRequest.failure
                ? Center(child: Lottie.asset(AppImagesAssets.emptybox))
                : statusRequest == StatusRequest.serverFailure
                    ? Center(child: Lottie.asset(AppImagesAssets.tryagain))
                    : widget;
  }
}
