import 'package:chat/config/custom_elevatedbutton.dart';
import 'package:chat/core/constant/App_images.dart';
import 'package:chat/core/constant/images_assets.dart';
import 'package:chat/core/constant/routes.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/functions/valid.dart';
import 'package:chat/core/shared/custom_app_bar.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/custom_textformfield.dart';
import '../../../../core/constant/app_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of(context);
    final scaffoldKey = GlobalKey<ScaffoldState>(); // HERE

    return Scaffold(
      key: cubit.scaffoldKeyResit,
      appBar: const CustomAppBar(
          iconBack: true, title: "Forget password", isTitle: true),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgetPassLoadingState) {
            return showLoadingIndicator(context);
          } else if (state is ForgetPassFailedState) {
            Navigator.pop(context);
            showToast(msg: state.msg);
          } else if (state is ForgetPassSuccessState) {
            Navigator.pop(context);

            showToast(msg: "Check Yor Email To Reset Password", isError: false);
            navigateTo(page: const LoginScreen());
            // Navigator.pushNamedAndRemoveUntil(
            //     context, AppRoutesNamed.loginScreen, (route) => false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.forgetPassword,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Lottie.asset(
                          AppImagesAssets.forgotPassword,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      space(50, 0),
                      CustomTextFormField(
                          controller: cubit.userEmailController,
                          validator: (v) {
                            return validInput(v!, 3, 255);
                          },
                          icon: Icons.account_circle_outlined,
                          hintText: AppString.loginEmailHintText,
                          label: AppString.loginEmailLabel),
                      space(50, 0),
                      CustomElevatedButton(
                          name: "Send verification link",
                          onPressed: () {
                            if (cubit.forgetPassword.currentState!.validate()) {
                              cubit.resetPassword();
                            }
                          }),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
