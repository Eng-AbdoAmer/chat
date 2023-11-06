import 'package:chat/features/onboarding_splash/presentation/manager/onboarding_cubit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/onboarding_model.dart';

class CustomSliderController extends StatelessWidget {
  const CustomSliderController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = BlocProvider.of(context);
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingSuccessState) {}
      },
      builder: (context, state) {
        return PageView.builder(
          controller: cubit.pageController,
          onPageChanged: (value) {
            cubit.onPageChanged(value);
          },
          itemCount: onBoardingList.length,
          itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(onBoardingList[index].title,
                  style: Theme.of(context).textTheme.headlineMedium),
              SvgPicture.asset(
                onBoardingList[index].imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.9,
                fit: BoxFit.fill,
              ),
              Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(onBoardingList[index].description,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center)),
            ],
          ),
        );
      },
    );
  }
}
