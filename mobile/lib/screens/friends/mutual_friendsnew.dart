import 'package:mobile/models/mutualfriend.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../../../colors.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';

class MutualllFriendsScreen extends StatefulWidget {
  const MutualllFriendsScreen({super.key});

  @override
  MutualllFriendsScreenState createState() {
    return MutualllFriendsScreenState();
  }
}

class MutualllFriendsScreenState extends State<MutualllFriendsScreen> {
  static List<mutualfriendModel> main_friends_list = [
    mutualfriendModel("Dulaj", "Lecture",
        "https://images.pexels.com/photos/1165641/pexels-photo-1165641.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    mutualfriendModel("Nimeshi", "Students",
        "https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg?auto=compress&cs=tinysrgb&w=600"),
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
              Text(
                "Search for friend",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
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
                  hintText: "Who are you looking forr?",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: display_list.length,
                    itemBuilder: ((context, index) => ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(
                            display_list[index].Name!,
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          subtitle: Text(
                            display_list[index].position!,
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                          // leading: CircleAvatar(backgroundImage: Image.network())
                        ))),
              )
            ]),
      ),
    );
  }
}
