import 'package:chat/core/constant/app_strings.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_elevatedbutton.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_row.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_text_body.dart';
import 'package:chat/ui/auth_page/widgets/auth/custom_textformfield.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/aleart_exit_app.dart';
import '../../../core/functions/custom_sizebox.dart';
import '../../../core/functions/google_signIn.dart';
import '../../../core/functions/valid.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.loginWelcome,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.grey, fontSize: 25),
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
                      Image.network(
                        AppString.loginImageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      space(10, 0),
                      CustomTextFormField(
                          obscureText: false,
                          validator: (v) {
                            return validInput(v!, 3, 255);
                          },
                          icon: Icons.email_outlined,
                          hintText: AppString.loginEmailHintText,
                          label: AppString.loginEmailLabel),
                      space(15, 0),
                      CustomTextFormField(
                          validator: (v) {
                            return validInput(v!, 3, 255);
                          },
                          obscureText: true,
                          hintText: AppString.loginPasswordHintText,
                          label: AppString.loginPasswordLabel),
                      space(15, 0),
                      const InkWell(
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomTextBody(
                              textAlign: TextAlign.end,
                              body: AppString.loginForgetPassword),
                        ),
                      ),
                      space(15, 0),
                      CustomElevatedButton(
                          name: AppString.login,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutesNamed.homePage, (route) => false);
                            }
                          }),
                      space(5, 0),
                      CustomElevatedButton(
                          name: AppString.loginByGoogle,
                          onPressed: () async {
                            await googleSignIn();
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutesNamed.homePage, (route) => false);
                          }),
                      space(10, 0),
                      CustomRow(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutesNamed.register, (route) => false);
                        },
                        title: AppString.dontHaveAccount,
                        subTitle: AppString.clickHer,
                      ),
                      //CustomRow(),
                    ],
                  ),
                ),
              ),
            )));
  }
}
