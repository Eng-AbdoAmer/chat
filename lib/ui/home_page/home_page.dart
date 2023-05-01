import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/functions/aleart_exit_app.dart';
import '../../core/functions/app_dialoge.dart';
import '../../core/functions/custom_search_delegate.dart';
import '../../models/model_homed_page.dart';
import '../chat_massage_screen/chat_massage_screen.dart';
import '../item_chat.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final auth = FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                aleartExitApp();
              },
              icon: Icon(Icons.logout)),
        ],
        leading: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(
              Icons.search,
              size: 25,
            )),
      ),
      body: ListView.builder(
        itemCount: chatsList.length,
        itemBuilder: (context, index) => ItemChat(
            model: chatsList[index],
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatMassageScreen()));
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            appDialog(
              title: 'Thank you',
              onPressedOKClick: () {
                Navigator.of(context).pop();
              },
              subtitle: "almost we make add user",
              click: "ok",
            );
          },
          child: const Icon(Icons.group_add_outlined)),
    );
  }
}
