import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class BuildSenderMessage extends StatefulWidget {
  BuildSenderMessage({Key? key, required this.controller}) : super(key: key);
  var controller = TextEditingController();

  @override
  State<BuildSenderMessage> createState() => _BuildSenderMessageState();
}

class _BuildSenderMessageState extends State<BuildSenderMessage> {
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
                  color: AppColors.grey.withOpacity(0.5),
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
                        hintText: "Enter your message",
                        border: InputBorder.none),
                  )),
                  widget.controller.text.isEmpty
                      ? IconButton(
                          onPressed: () async {
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
                            //ToDo:send data massage
                            setState(() {});
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
