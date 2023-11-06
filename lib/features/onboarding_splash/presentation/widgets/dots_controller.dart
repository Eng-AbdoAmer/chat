import 'package:chat/features/onboarding_splash/presentation/manager/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../data/models/onboarding_model.dart';

class DotController extends StatelessWidget {
  const DotController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = BlocProvider.of(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                onBoardingList.length,
                (index) => AnimatedContainer(
                      margin: const EdgeInsets.only(right: 5),
                      duration: const Duration(microseconds: 900),
                      width: cubit.currentPage == index ? 20 : 5,
                      height: 6,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ))
          ],
        );
      },
    );
  }
}
