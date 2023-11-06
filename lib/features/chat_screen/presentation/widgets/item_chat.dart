import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ItemChat extends StatelessWidget {
  final UserModel? model;
  final VoidCallback press;
  const ItemChat({Key? key, required this.model, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        onTap: press,
        title: Text(
          model!.name ?? "",
          style: const TextStyle(color: AppColors.black, fontSize: 18),
        ),
        subtitle: Text(model!.email ?? "",
            style: const TextStyle(color: AppColors.grey2, fontSize: 16)),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(model!.image ?? ""),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model!.isActive ? Colors.green : Colors.redAccent,
                    border: Border.all(color: Colors.white, width: 1)),
              ),
            )
          ],
        ),
        trailing: Text(model!.time ?? "",
            style: const TextStyle(color: AppColors.grey, fontSize: 14)),
      ),
    );
  }
}
