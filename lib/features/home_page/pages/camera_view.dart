import 'dart:io';
import 'package:chat/config/custom_textformfield.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:chat/features/home_page/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/story_model.dart';

class CameraView extends StatelessWidget {
  final String imagePath;
  const CameraView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UploadImageSuccessState) {
          cubit.imageUrl = state.imageUrl;
          cubit
              .addStories(
                  senderEmail: cubit.emailProfile,
                  mediaType: MediaType.image.name,
                  comment: cubit.commentAtStory.text.trim(),
                  imageUrl: state.imageUrl)
              .then((value) {
            navigateTo(page: const HomePage());
          });
        } else if (state is CameraFailedState) {
          cubit.isProfilePathDet = state.isProfilePathDet;
          Navigator.pop(context);
          showToast(msg: state.msg);
        } else if (state is UploadImageLoadingState) {
          return showLoadingIndicator(context);
        } else if (State is CameraSuccessState) {}
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightBlack,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width,
                child: Image.file(File(imagePath)),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: CustomTextFormField(
                            controller: cubit.commentAtStory,
                            maxLines: 1,
                            hintText: "Type Something",
                          )),
                      space(0, 5),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            cubit.upLoadImageToStorage(file: XFile(imagePath));
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(
                              Icons.send,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
