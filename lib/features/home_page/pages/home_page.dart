// import 'package:chat/core/functions/show_loading_indicator_f.unction.dart';
// import 'package:chat/core/shared/helper_meuthods.dart';
// import 'package:chat/features/chat_screen/presentation/cubit/chat_screen_cubit.dart';
// import 'package:chat/features/chat_screen/presentation/pages/chat_screen.dart';
// import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
// import 'package:chat/features/home_page/pages/home_custom.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../chat_screen/presentation/widgets/item_chat.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     HomeCubit cubit = BlocProvider.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title:const Text("Home Screen"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 cubit.signOut(context);
//               },
//               icon:const Icon(Icons.logout)),
//           IconButton(
//               onPressed: () {
//                 navigateTo(page: const CustomHome());
//               },
//               icon: const Icon(Icons.account_balance))
//         ],
//         // leading: IconButton(
//         //     onPressed: () {
//         //       showSearch(context: context, delegate: CustomSearchDelegate());
//         //     },
//         //     icon: Icon(
//         //       Icons.search,
//         //       size: 25,
//         //     )),
//       ),
//       body: BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is GetUserLoadingState) {
//             return showLoadingIndicator(context);
//           } else if (state is GetUserFailedState) {
//             Navigator.pop(context);
//             showToast(msg: state.msg);
//           } else if (state is GetUserSuccessState) {
//             //showToast(msg: "", isError: false);
//             cubit.users = state.model;
//           }
//         },
//         builder: (context, state) {
//           return ListView.builder(
//             itemCount: cubit.users.length,
//             itemBuilder: (context, index) => ItemChat(
//                 model: cubit.users[index],
//                 press: () {
//                   ChatScreenCubit chatScreenCubit = BlocProvider.of(context);
//                   chatScreenCubit.getAllMessage(
//                       receiverId: cubit.users[index].email!);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ChatScreen(
//                                 model: cubit.users[index],
//                               )));
//                 }),
//           );
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //     onPressed: () {
//       //       appDialog(
//       //         title: 'Thank you',
//       //         onPressedOKClick: () {
//       //           Navigator.of(context).pop();
//       //         },
//       //         subtitle: "almost we make add user",
//       //         click: "ok",
//       //       );
//       //     },
//       //     child: const Icon(Icons.group_add_outlined)),
//     );
//   }
// }
