import 'package:chat/core/constant/App_images.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/services/cache_helper.dart';
import 'package:chat/core/services/locator.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/chat_screen/presentation/cubit/chat_screen_cubit.dart';
import 'package:chat/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:chat/features/chat_screen/presentation/widgets/item_chat.dart';
import 'package:chat/features/home_page/data/models/story_model.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:chat/features/home_page/pages/story_view.dart';
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
                    name: cubit.nameProfile,
                    time: cubit.timeProfile,
                    onPressedAdd: () {
                      cubit.addStories(
                          senderEmail: cubit.emailProfile,
                          mediaType: MediaType.image.name,
                          comment: "How can i help you?",
                          imageUrl:
                              "https://firebasestorage.googleapis.com/v0/b/chat-fc367.appspot.com/o/staties%2Fclient1.jpg?alt=media&token=e2dd4ba9-33a1-410c-a354-2f383a2473d1");
                    },
                    onPressedNotification: () {},
                  )),
              SliverToBoxAdapter(
                child: Container(
                  height: 500,
                  color: AppColors.white,
                  child: cubit.users.isNotEmpty
                      ? ListView.builder(
                          itemCount: cubit.users.length,
                          itemBuilder: (context, index) => ItemChat(
                              model: cubit.users[index],
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
