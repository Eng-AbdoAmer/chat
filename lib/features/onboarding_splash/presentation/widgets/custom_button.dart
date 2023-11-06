import 'package:chat/config/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/onboarding_cubit.dart';

class CustomButtonOnBoarding extends StatelessWidget {
  const CustomButtonOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = BlocProvider.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: 220,
      child: CustomElevatedButton(
        name: "next",
        onPressed: () {
          cubit.next();
        },
      ),
    );
  }
}
