import 'package:chat/features/onboarding_splash/presentation/manager/onboarding_cubit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_slider.dart';
import '../widgets/dots_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = BlocProvider.of(context);
    cubit.emit(OnboardingLoadingState());
    cubit.pageController = PageController();
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return const Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(flex: 3, child: CustomSliderController()),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        DotController(),
                        CustomButtonOnBoarding(),
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
