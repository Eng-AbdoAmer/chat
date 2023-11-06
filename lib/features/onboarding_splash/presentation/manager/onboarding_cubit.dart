import 'package:bloc/bloc.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/presentation/pages/register.dart';
import 'package:flutter/Material.dart';

import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/locator.dart';
import '../../data/models/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int currentPage = 0;
  late PageController pageController;

  next() {
    emit(OnboardingLoadingState());
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      // myServices.sharedPreferences.setString("onBoarding", "1");
      locator<CacheHelper>().saveData(key: "isOnBoardingActive", value: true);
      navigateTo(page: const Register());
      emit(OnboardingSuccessState());
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(microseconds: 900),
          curve: Curves.easeInOutQuint);
    }
  }

  onPageChanged(int index) {
    currentPage = index;
    emit(OnboardingSuccessState());
  }
}
