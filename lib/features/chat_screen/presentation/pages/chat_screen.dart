import 'package:chat/config/custom_textformfield.dart';
import 'package:chat/core/constant/App_images.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/functions/LoadingIndicator.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/chat_screen/presentation/cubit/chat_screen_cubit.dart';
import 'package:chat/features/chat_screen/presentation/widgets/custom_recevied_msg.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatelessWidget {
  final UserModel? model;
  const ChatScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    ChatScreenCubit cubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(model!.image!),
            ),
            space(0, 10),
            Text(
              model!.name!,
              style: const TextStyle(fontSize: 18, color: AppColors.black),
            )
          ],
        ),
      ),
      body: BlocConsumer<ChatScreenCubit, ChatScreenState>(
        listener: (context, state) {
          if (state is ChatScreenNoMessagesState) {
            print("no messages");
          } else if (state is ChatScreenFailedState) {
            Navigator.pop(context);
            showToast(msg: state.msg);
          } else if (state is ChatScreenSuccessGetAllMessageState) {
            cubit.messagesList = [];
            cubit.messagesList = state.model;
          } else if (state is ChatScreenSuccessState) {
          } else if (state is ChatScreenLoadingState) {}
        },
        builder: (context, state) {
          if (state is ChatScreenNoMessagesState) {
            return Center(
              child: Lottie.asset(AppImages.emptyBox),
            );
          }
          return ConditionalBuilder(
              condition: cubit.messagesList.isNotEmpty,
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CustomReceviedMsg(
                              recevedId: model!.email!,
                              model: cubit.messagesList[index]);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: cubit.messagesList.length),
                  ),
              fallback: (context) => const Center(child: LoadingIndicator()));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: CustomTextFormField(
                  controller: cubit.message,
                  maxLines: 1,
                  hintText: "Type Something",
                  icon: Icons.mic,
                )),
            space(0, 5),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  print("send");
                  cubit.addMessage(receiverId: model!.email!);
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
    );
  }
}
