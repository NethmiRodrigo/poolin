import 'package:poolin/models/mutual_friends.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/custom/outline_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/utils/widget_functions.dart';
import '../../../colors.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';

class CloseFriendsScreen extends StatefulWidget {
  const CloseFriendsScreen({super.key});

  @override
  CloseFriendsScreenState createState() {
    return CloseFriendsScreenState();
  }
}

class CloseFriendsScreenState extends State<CloseFriendsScreen> {
  static List<mutualfriendModel> main_friends_list = [
    mutualfriendModel(
        "Dulaj Prabash", "Lecture", "assets/images/man.jpeg", "See more"),
    mutualfriendModel("Nimeshi karunarathne", "Students",
        "assets/images/woman.jpeg", "See more"),
    mutualfriendModel(
        "Deshan alpitiya", "Students", "assets/images/user.jpg", "See more"),
    mutualfriendModel(
        "Shershi gomitri", "Students", "assets/images/woman.jpeg", "See more"),
  ];

  List<mutualfriendModel> display_list = List.from(main_friends_list);

  void updatelist(String value) {
    setState(() {
      display_list = main_friends_list
          .where((element) =>
              element.Name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  
                },
              ),
              Text(
                "Close friends",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              //////////////////////////////////////////////////
              TextField(
                onChanged: (value) => updatelist(value),
                autofocus: true,
                showCursor: true,
                readOnly: false,
                style: Theme.of(context).textTheme.labelLarge,
                textAlignVertical: TextAlignVertical.center,
                key: const Key('destination-field'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(AkarIcons.search),
                  hintText: "Who are you looking for?",
                ),
              ),
              
              SizedBox(
                height: 20,
              ),
              ///////////////////////////////////////////////////////////////
              
            ]),
      ),
    );
  }
}
