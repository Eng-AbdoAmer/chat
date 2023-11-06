import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

import '../constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.title, this.iconBack = true, this.isTitle = true});

  final String? title;
  final bool iconBack;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: iconBack
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
          : const SizedBox(),
      title: isTitle
          ? Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: AppColors.black, fontSize: 14))
          : const SizedBox(),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(32);
}
