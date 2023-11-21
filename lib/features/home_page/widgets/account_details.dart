import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/functions/custom_search_delegate.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:chat/features/home_page/pages/story_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/custom_textformfield.dart';

class AccountDetails extends StatelessWidget {
  final String name, time;
  final TextEditingController? searchController;
  final void Function()? onPressedNotification;
  final void Function()? onPressedAdd;
  const AccountDetails(
      {super.key,
      required this.name,
      required this.time,
      this.onPressedNotification,
      this.searchController,
      this.onPressedAdd});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is StoriesLoadingState) {
          return showLoadingIndicator(context);
        }
        if (state is StoriesSuccessState) {
          cubit.storyModelList = state.model;
          cubit.addStoryItem();
          navigateTo(page: StoryPage(model: state.model));
        }
        if (state is StoriesFailedState) {
          Navigator.pop(context);
          showToast(msg: state.msg);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 239, 162, 102),
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: onPressedNotification,
                            icon: const Icon(
                              Icons.notifications,
                              size: 20,
                              color: AppColors.white,
                            )),
                      ),
                      space(0, 10),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 239, 162, 102),
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: onPressedAdd,
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.white,
                            )),
                      )
                    ],
                  )
                ],
              ),
              space(20, 0),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: CustomTextFormField(
                    onChanged: (v) {
                      HomeCubit cubit = BlocProvider.of(context);
                      cubit.searchUsers = cubit.users
                          .where((element) =>
                              element.name!.toLowerCase().startsWith(v))
                          .toList();
                      cubit.emit(HomeSuccessState());
                    },
                    // onTap: (){
                    //   showSearch(context: context, delegate: CustomSearchDelegate());
                    // },
                    controller: searchController,
                    hintText: "type any Thing?",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.white,
                      size: 25,
                    )),
              ),
              space(20, 0),
              SizedBox(
                  height: 150,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        cubit.getStories(
                            emailSender: cubit.users[index].email!);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                NetworkImage(cubit.users[index].image!),
                          ),
                          space(5, 0),
                          Text(
                            cubit.users[index].name!,
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.white),
                          )
                        ],
                      ),
                    ),
                    itemCount: cubit.users.length,
                  )),
            ]),
          ),
        );
      },
    );
  }
}
