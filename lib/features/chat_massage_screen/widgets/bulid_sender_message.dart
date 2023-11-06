import 'package:chat/core/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/functions/image_paker_helper.dart';
import '../../../core/functions/send_text_to_google.dart';

class BulidSenderMessage extends StatefulWidget {
  BulidSenderMessage({Key? key, required this.controller}) : super(key: key);
  var controller = TextEditingController();

  @override
  State<BulidSenderMessage> createState() => _BulidSenderMessageState();
}

class _BulidSenderMessageState extends State<BulidSenderMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(1),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: AppColors.white,
                      )),
                  Expanded(
                      child: TextField(
                    controller: widget.controller,
                    decoration: const InputDecoration(
                        hintText: AppString.typeAMessage,
                        border: InputBorder.none),
                  )),
                  widget.controller.text.isEmpty
                      ? IconButton(
                          onPressed: () async {
                            toTakeImageFromCameraAndSaveAtFireBase(
                                ImageSource.camera);
                            setState(() {
                              //TODO:must do=> controller.clear;
                              widget.controller.clear();
                            });
                          },
                          icon: const Icon(Icons.camera_alt_outlined),
                          color: AppColors.white,
                        )
                      : const SizedBox(),
                  widget.controller.text.isEmpty
                      ? IconButton(
                          onPressed: () {
                            toTakeImageFromCameraAndSaveAtFireBase(
                                ImageSource.gallery);
                            setState(() {
                              //TODO:must do=> controller.clear;
                              widget.controller.clear();
                            });
                          },
                          icon: const Icon(Icons.attach_file),
                          color: AppColors.white,
                        )
                      : const SizedBox(),
                  widget.controller.text.isNotEmpty
                      ? const SizedBox(
                          width: 5,
                        )
                      : const SizedBox(),
                  widget.controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: () async {
                            sendTextToGoogle(widget.controller);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.white,
                          ))
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
