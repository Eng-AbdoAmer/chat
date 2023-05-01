import 'package:flutter/material.dart';

import '../../models/model_homed_page.dart';
import '../../ui/chat_massage_screen/chat_massage_screen.dart';
import '../../ui/item_chat.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List searchItems = [];
    searchItems = chatsList
        .where((element) => element.name
            .toLowerCase()
            .startsWith(query.toLowerCase().toString()))
        .toList();

    return ListView.builder(
      itemCount: searchItems.length,
      itemBuilder: (context, index) => ItemChat(
          model: searchItems[index],
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatMassageScreen()));
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //  List<MessageModel> searchItems = [];
    return ListView.builder(
      itemCount: chatsList.length,
      itemBuilder: (context, index) => ItemChat(
          model: chatsList[index],
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatMassageScreen()));
          }),
    );
  }
}

//TODO AT Bottom
// onPressed: () {
// showSearch(context: context, delegate: CustomSearchDelegate());
// }
