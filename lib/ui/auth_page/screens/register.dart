import 'package:chat/core/constant/app_strings.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_elevatedbutton.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_row.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images_assets.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/aleart_exit_app.dart';
import '../../../core/functions/custom_sizebox.dart';
import '../../../core/functions/valid.dart';
import '../../../core/shared/helper_meuthods.dart';
import '../../home_page/home_page.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.register,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppColors.grey, fontSize: 30),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.white,
      ),
      body: WillPopScope(
        onWillPop: aleartExitApp,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(
                    AppImagesAssets.registration,
                    width: double.infinity,
                    height: 200,
                  ),
                  space(10, 0),
                  CustomTextFormField(
                      obscureText: false,
                      validator: (v) {
                        return validInput(v!, 3, 255);
                      },
                      icon: Icons.account_circle_outlined,
                      hintText: AppString.registerNameHintText,
                      label: AppString.registerNameLabel),
                  space(20, 0),
                  CustomTextFormField(
                      obscureText: false,
                      validator: (v) {
                        return validInput(v!, 3, 255);
                      },
                      icon: Icons.phone_android,
                      hintText: AppString.registerPhoneNumberHintText,
                      label: AppString.registerPhoneLabel),
                  space(20, 0),
                  CustomTextFormField(
                      obscureText: false,
                      validator: (v) {
                        return validInput(v!, 3, 255);
                      },
                      icon: Icons.email_outlined,
                      hintText: AppString.loginEmailHintText,
                      label: AppString.loginEmailLabel),
                  space(20, 0),
                  CustomTextFormField(
                      validator: (v) {
                        return validInput(v!, 3, 255);
                      },
                      obscureText: true,
                      icon: Icons.visibility_off_outlined,
                      hintText: AppString.loginPasswordHintText,
                      label: AppString.loginPasswordLabel),
                  space(20, 0),
                  CustomElevatedButton(
                      name: AppString.register,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          navigateTo(page: HomePage());
                        }
                      }),
                  space(10, 0),
                  CustomRow(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutesNamed.loginScreen);
                      },
                      title: AppString.haveAccount,
                      subTitle: AppString.clickHer),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
