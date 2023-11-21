// import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
// import 'package:chat/features/auth/data/models/user_model.dart';
// import 'package:chat/features/chat_screen/presentation/cubit/chat_screen_cubit.dart';
// import 'package:chat/features/chat_screen/presentation/pages/chat_screen.dart';
// import 'package:chat/features/chat_screen/presentation/widgets/item_chat.dart';
// import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
// import 'package:chat/features/home_page/pages/camera_view.dart';
// import 'package:chat/features/home_page/pages/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../shared/helper_meuthods.dart';

// class CustomSearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.clear)),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     HomeCubit cubit = BlocProvider.of(context);
//     List searchItems = [];
//     searchItems = cubit.users
//         .where((element) => element.name!
//             .toLowerCase()
//             .startsWith(query.toLowerCase().toString()))
//         .toList();

//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is GetUserLoadingState) {
//           return showLoadingIndicator(context);
//         } else if (state is GetUserFailedState) {
//           Navigator.pop(context);
//           showToast(msg: state.msg);
//         } else if (state is GetUserSuccessState) {
//           cubit.users = state.model;
//           if (state.model.isEmpty) {
//             showToast(msg: "messages is Empty", isError: false);
//           }
//         } else if (state is StoriesAddSuccessState) {
//           navigateTo(page: const HomePage());
//         } else if (state is CameraSuccessState) {
//           cubit.filePath = state.pathImage;
//           cubit.isProfilePathDet = state.isProfilePathDet;
//           navigateTo(page: CameraView(imagePath: state.pathImage));
//           //cubit.upLoadImageToStorage(file: cubit.file!);
//         } else if (state is CameraFailedState) {
//           cubit.isProfilePathDet = state.isProfilePathDet;
//           Navigator.pop(context);
//           showToast(msg: state.msg);
//         }
//       },
//       builder: (context, state) {
//         return ListView.builder(
//           itemCount: searchItems.length,
//           itemBuilder: (context, index) => ItemChat(
//               model: cubit.users[index],
//               press: () {
//                 ChatScreenCubit chatScreenCubit = BlocProvider.of(context);
//                 chatScreenCubit.getAllMessage(
//                     receiverId: cubit.users[index].email!);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                               model: cubit.users[index],
//                             )));
//               }),
//         );
//       },
//     );
//     // return Text("buildLeading");
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     HomeCubit cubit = BlocProvider.of(context);

//     List<UserModel> searchItems = [];
//     print("searchItems.length" + searchItems.length.toString());
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is GetUserLoadingState) {
//           return showLoadingIndicator(context);
//         } else if (state is GetUserFailedState) {
//           Navigator.pop(context);
//           showToast(msg: state.msg);
//         } else if (state is GetUserSuccessState) {
//           cubit.users = state.model;
//           if (state.model.isEmpty) {
//             showToast(msg: "messages is Empty", isError: false);
//           }
//         } else if (state is StoriesAddSuccessState) {
//           navigateTo(page: const HomePage());
//         } else if (state is CameraSuccessState) {
//           cubit.filePath = state.pathImage;
//           cubit.isProfilePathDet = state.isProfilePathDet;
//           navigateTo(page: CameraView(imagePath: state.pathImage));
//           //cubit.upLoadImageToStorage(file: cubit.file!);
//         } else if (state is CameraFailedState) {
//           cubit.isProfilePathDet = state.isProfilePathDet;
//           Navigator.pop(context);
//           showToast(msg: state.msg);
//         }
//       },
//       builder: (context, state) {
//         return ListView.builder(
//           itemCount: searchItems.length,
//           itemBuilder: (context, index) => ItemChat(
//               model: searchItems[index],
//               press: () {
//                 ChatScreenCubit chatScreenCubit = BlocProvider.of(context);
//                 chatScreenCubit.getAllMessage(
//                     receiverId: cubit.users[index].email!);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                               model: cubit.users[index],
//                             )));
//               }),
//         );
//       },
//     );
//     // return Text("buildSuggestions");
//   }
// }

// // //TODO AT Bottom
// // // onPressed: () {
// // // showSearch(context: context, delegate: CustomSearchDelegate());
// // // }
