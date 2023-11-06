import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/custom_sizebox.dart';

class SocialBtn extends StatelessWidget {
  final Widget? icon;
  const SocialBtn({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            cubit.signInWithFacebook2();
          },
          child: const CircleAvatar(
            backgroundColor: AppColors.grey3,
            radius: 25,
            child: Icon(BootstrapIcons.facebook),
          ),
        ),
        space(0, 15),
        InkWell(
          onTap: () {
            cubit.googleSignIn();
          },
          child: const CircleAvatar(
            backgroundColor: AppColors.grey3,
            radius: 25,
            child: Icon(BootstrapIcons.google),
          ),
        ),
      ],
    );
  }
}
