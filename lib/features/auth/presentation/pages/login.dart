import 'package:chat/core/constant/app_strings.dart';
import 'package:chat/core/constant/routes.dart';
import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
import 'package:chat/core/shared/custom_app_bar.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat/features/auth/presentation/pages/forget_password.dart';
import 'package:chat/features/auth/presentation/pages/register.dart';
import 'package:chat/features/auth/presentation/widgets/custom_elevatedbutton.dart';
import 'package:chat/features/auth/presentation/widgets/custom_text_body.dart';
import 'package:chat/features/home_page/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/custom_textformfield.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/custom_text_style.dart';
import '../../../../core/functions/aleart_exit_app.dart';
import '../../../../core/functions/custom_sizebox.dart';
import '../../../../core/functions/valid.dart';
import '../widgets/custom_row.dart';
import '../widgets/social_btn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of(context);
    return Scaffold(
        key: cubit.scaffoldKeyLogin,
        appBar: const CustomAppBar(isTitle: false, iconBack: false),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              return showLoadingIndicator(context);
            } else if (state is LoginFailedState) {
              Navigator.pop(context);
              showToast(msg: state.msg);
            } else if (state is LoginSuccessState) {
              bool isEmailVerified =
                  FirebaseAuth.instance.currentUser!.emailVerified;
              if (isEmailVerified) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false);
              } else {
                showToast(msg: "please Verify Your Account");
                Navigator.pop(context);
              }
            }
          },
          builder: (context, state) {
            return WillPopScope(
                onWillPop: aleartExitApp,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Form(
                    key: cubit.loginKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Center(child: Text("Welcome Back")),
                          space(10, 0),
                          const Center(
                              child: CircleAvatar(
                            radius: 100,
                            backgroundColor: AppColors.primaryColor,
                            child: Text(
                              "Chat",
                              style: CustomTextStyle.pacifico500style35Whit,
                            ),
                          )),
                          space(10, 0),
                          CustomTextFormField(
                              controller: cubit.userEmailController,
                              obscureText: false,
                              validator: (v) {
                                return validInput(v!, 3, 255);
                              },
                              icon: Icons.email_outlined,
                              hintText: AppString.loginEmailHintText,
                              label: AppString.loginEmailLabel),
                          space(15, 0),
                          CustomTextFormField(
                              controller: cubit.userPasswordController,
                              validator: (v) {
                                return validInput(v!, 3, 255);
                              },
                              obscureText: true,
                              hintText: AppString.loginPasswordHintText,
                              label: AppString.loginPasswordLabel),
                          space(15, 0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  navigateTo(page: const ForgetPassword());
                                },
                                child: Text(
                                  AppString.loginForgetPassword,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                          ),
                          space(15, 0),
                          CustomElevatedButton(
                              name: AppString.login,
                              onPressed: () {
                                cubit.onPressLoginWithEmailAndPassword();
                              }),
                          space(15, 0),
                          const SocialBtn(),
                          space(10, 0),
                          CustomRow(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutesNamed.register, (route) => false);
                              // navigateTo(page: const Register());
                            },
                            title: AppString.dontHaveAccount,
                            subTitle: AppString.clickHer,
                          ),
                          //CustomRow(),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
