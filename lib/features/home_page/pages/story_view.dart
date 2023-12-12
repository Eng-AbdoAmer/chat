import 'package:chat/core/constant/routes.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/home_page/data/models/story_model.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:chat/features/home_page/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';

class StoryPage extends StatelessWidget {
  final List<StoryModel> model;
  const StoryPage({super.key, required this.model});

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
        }
        if (state is StoriesFailedState) {
          Navigator.pop(context);
          showToast(msg: state.msg);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: StoryView(
              controller: cubit.controller,
              storyItems: cubit.storyItem,
              onStoryShow: (s) {
                print("Showing a story");
              },
              onComplete: () {
                //Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutesNamed.homePage, (route) => false);
                print("Completed a cycle");
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  // Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutesNamed.homePage, (route) => false);
                }
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              inline: true,
            ),
          ),
        );
      },
    );
  }
}
