import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/functions/custom_sizebox.dart';
import 'package:flutter/material.dart';
import '../../../config/custom_textformfield.dart';

class AccountDetails extends StatelessWidget {
  final String name, time;
  final TextEditingController? searchController;
  final void Function()? onPressedNotification;
  const AccountDetails(
      {super.key,
      required this.name,
      required this.time,
      this.onPressedNotification,
      this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.blue,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:const TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    time,
                    style:const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: onPressedNotification,
                    icon:const Icon(
                      Icons.notifications,
                      size: 20,
                      color: AppColors.white,
                    )),
              )
            ],
          ),
          space(20, 0),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.white),
                borderRadius: BorderRadius.circular(10)),
            child: CustomTextFormField(
                controller: searchController,
                hintText: "type any Thing?",
                prefixIcon:const Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 25,
                )),
          ),
          space(20, 0),
          SizedBox(
              height: 150,
              child: ListView.separated(
                separatorBuilder: (context, index) =>const SizedBox(width: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Column(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/18748302/pexels-photo-18748302/free-photo-of-person-posing-in-front-of-ocean-smiling.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load"),
                    ),
                    space(5, 0),
                    const Text(
                      "Alice",
                      style: TextStyle(fontSize: 16, color: AppColors.white),
                    )
                  ],
                ),
                itemCount: 10,
              )),
        ]),
      ),
    );
  }
}
