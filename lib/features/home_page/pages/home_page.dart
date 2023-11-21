import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/core/constant/App_images.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/functions/app_dialoge.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/chat_screen/presentation/cubit/chat_screen_cubit.dart';
import 'package:chat/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:chat/features/chat_screen/presentation/widgets/item_chat.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:chat/features/home_page/pages/camera_view.dart';
import 'package:chat/features/home_page/widgets/account_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetUserLoadingState) {
              return showLoadingIndicator(context);
            } else if (state is GetUserFailedState) {
              Navigator.pop(context);
              showToast(msg: state.msg);
            } else if (state is GetUserSuccessState) {
              cubit.users = state.model;
              if (state.model.isEmpty) {
                showToast(msg: "messages is Empty", isError: false);
              }
            } else if (state is StoriesAddSuccessState) {
              navigateTo(page: const HomePage());
            } else if (state is CameraSuccessState) {
              cubit.filePath = state.pathImage;
              cubit.isProfilePathDet = state.isProfilePathDet;
              navigateTo(page: CameraView(imagePath: state.pathImage));
              //cubit.upLoadImageToStorage(file: cubit.file!);
            } else if (state is CameraFailedState) {
              cubit.isProfilePathDet = state.isProfilePathDet;
              Navigator.pop(context);
              showToast(msg: state.msg);
            }
          },
          builder: (context, state) {
            return CustomScrollView(slivers: [
              SliverAppBar(
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(-15),
                      child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child:
                              const Center(child: Text("Favorite Contact")))),
                  pinned: true,
                  expandedHeight: 300,
                  backgroundColor: AppColors.primaryColor,
                  flexibleSpace: AccountDetails(
                    searchController: cubit.searchController,
                    name: cubit.nameProfile,
                    time: cubit.timeProfile,
                    onPressedAdd: () {
                      customDialogWithBody(
                        title: "Add New Story",
                        desc: "select type of story?",
                        dialogType: DialogType.success,
                        pressImage: () {
                          cubit.viewImage();
                        },
                        pressText: () {},
                      );
                      // cubit.addStories(
                      //     senderEmail: cubit.emailProfile,
                      //     mediaType: MediaType.image.name,
                      //     comment: "How can i help you?",
                      //     imageUrl:
                      //         "https://firebasestorage.googleapis.com/v0/b/chat-fc367.appspot.com/o/staties%2Fdriver3.jpg?alt=media&token=4f816096-6520-483f-aff1-73359dc15b00");
                    },
                    onPressedNotification: () {},
                  )),
              SliverToBoxAdapter(
                child: Container(
                  height: 500,
                  color: AppColors.white,
                  child: cubit.users.isNotEmpty
                      ? ListView.builder(
                          itemCount: cubit.searchController.text.isEmpty
                              ? cubit.users.length
                              : cubit.searchUsers.length,
                          itemBuilder: (context, index) => ItemChat(
                              model: cubit.searchController.text.isEmpty
                                  ? cubit.users[index]
                                  : cubit.searchUsers[index],
                              press: () {
                                ChatScreenCubit chatScreenCubit =
                                    BlocProvider.of(context);
                                chatScreenCubit.getAllMessage(
                                    receiverId: cubit.users[index].email!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              model: cubit.users[index],
                                            )));
                              }),
                        )
                      : Center(
                          child: Lottie.asset(AppImages.emptyBox),
                        ),
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
