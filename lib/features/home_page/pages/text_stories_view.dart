import 'dart:io';
import 'package:chat/config/custom_textformfield.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/constant/routes.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/story_model.dart';

class TextView extends StatelessWidget {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // if (state is UploadImageSuccessState) {
        // } else if (state is CameraFailedState) {
        //   cubit.isProfilePathDet = state.isProfilePathDet;
        //   Navigator.pop(context);
        //   showToast(msg: state.msg);
        // } else if (state is UploadImageLoadingState) {
        //   return showLoadingIndicator(context);
        // } else if (State is CameraSuccessState) {}
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit
                  .addStories(
                title: cubit.textAtStory.text.trim(),
                senderEmail: cubit.emailProfile,
                mediaType: MediaType.text.name,
              )
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutesNamed.homePage, (route) => false);
                //Navigator.of(context).
              });
            },
            child: Icon(Icons.send),
            backgroundColor: AppColors.primaryColor,
          ),
          backgroundColor: AppColors.lightBlack,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: TextFormField(
                      controller: cubit.textAtStory,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      mouseCursor: MouseCursor.uncontrolled,
                      textAlign: TextAlign.center,
                      cursorHeight: 40,
                      cursorColor: AppColors.grey3,
                      decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: 30, color: AppColors.grey),
                          hintText: "Type Something",
                          border: InputBorder.none),
                    )),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width,
              //     child: Row(
              //       children: [
              //         Expanded(
              //             flex: 3,
              //             child: CustomTextFormField(
              //               controller: cubit.commentAtStory,
              //               maxLines: 1,
              //               hintText: "Type Something",
              //             )),
              //         space(0, 5),
              //         Expanded(
              //           flex: 1,
              //           child: InkWell(
              //             onTap: () async {
              //               //TODO:upload text Stories to firestore
              //               //cubit.upLoadImageToStorage(file: XFile(imagePath));
              //             },
              //             child: Container(
              //               height: 50,
              //               width: 50,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: AppColors.primaryColor,
              //               ),
              //               child: const Icon(
              //                 Icons.send,
              //                 color: AppColors.white,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ]),
          ),
        );
      },
    );
  }
}
