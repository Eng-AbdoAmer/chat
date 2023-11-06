import 'dart:io';

import 'package:chat/core/constant/app_strings.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/custom_app_bar.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:chat/features/auth/presentation/widgets/custom_elevatedbutton.dart';
import 'package:chat/features/home_page/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../config/custom_textformfield.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/functions/aleart_exit_app.dart';
import '../../../../core/functions/custom_sizebox.dart';
import '../../../../core/functions/valid.dart';
import '../widgets/custom_row.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of(context);

    return Scaffold(
      key: cubit.scaffoldKeyRegister,
      appBar:
          const CustomAppBar(iconBack: false, title: "Register", isTitle: true),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            return showLoadingIndicator(context);
          } else if (state is RegisterSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
          } else if (state is RegisterFailedState) {
            Navigator.pop(context);
            showToast(msg: state.msg);
          } else if (state is CameraSuccessState) {
            cubit.filePath = state.pathImage;
            cubit.isProfilePathDet = state.isProfilePathDet;
            cubit.upLoadImageToStorage(file: cubit.file!);
          } else if (state is CameraFailedState) {
            cubit.isProfilePathDet = state.isProfilePathDet;
            Navigator.pop(context);
            showToast(msg: state.msg);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: aleartExitApp,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: cubit.registerKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text("choses your image"),
                      InkWell(
                        onTap: () {
                          cubit.viewImage();
                        },
                        child: cubit.isProfilePathDet
                            ? Image.file(
                                File(cubit.filePath),
                                height: 150,
                              )
                            : Image.asset(AppImagesAssets.camera,
                                fit: BoxFit.cover, height: 150),
                      ),
                      space(10, 0),
                      CustomTextFormField(
                          controller: cubit.nameController,
                          validator: (v) {
                            return validInput(v!, 3, 255);
                          },
                          icon: Icons.account_circle_outlined,
                          hintText: AppString.registerNameHintText,
                          label: AppString.registerNameLabel),
                      space(20, 0),
                      CustomTextFormField(
                          controller: cubit.userPhoneController,
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            return validInput(v!, 3, 255);
                          },
                          icon: Icons.phone_android,
                          hintText: AppString.registerPhoneNumberHintText,
                          label: AppString.registerPhoneLabel),
                      space(20, 0),
                      CustomTextFormField(
                          controller: cubit.userEmailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            return validInput(v!, 3, 255);
                          },
                          icon: Icons.email_outlined,
                          hintText: AppString.loginEmailHintText,
                          label: AppString.loginEmailLabel),
                      space(20, 0),
                      CustomTextFormField(
                          controller: cubit.userPasswordController,
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
                            cubit.onPressRegister();
                          }),
                      space(10, 0),
                      CustomRow(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutesNamed.loginScreen, (route) => false);
                          },
                          title: AppString.haveAccount,
                          subTitle: AppString.clickHer),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
