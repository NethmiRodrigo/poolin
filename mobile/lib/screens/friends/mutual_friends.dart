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

class MutuallFriendsScreen extends StatefulWidget {
  const MutuallFriendsScreen({super.key});

  @override
  MutuallFriendsScreenState createState() {
    return MutuallFriendsScreenState();
  }
}

class MutuallFriendsScreenState extends State<MutuallFriendsScreen> {
  static List<mutualfriendModel> main_friends_list = [
    // mutualfriendModel("Dulaj", "Lecture",
    //     "https://images.pexels.com/photos/1165641/pexels-photo-1165641.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    // mutualfriendModel("Nimeshi", "Students",
    //     "https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg?auto=compress&cs=tinysrgb&w=600"),
  ];

  List<mutualfriendModel> display_list = List.from(main_friends_list);

  void updatelist(String value) {}

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(32),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      EvaIcons.arrowBackOutline,
                      color: Colors.black,
                    )),
              ),
              addVerticalSpace(24),
              const Text(
                "Mutual Friends",
                style: BlipFonts.display,
              ),
              addVerticalSpace(32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //       itemCount: display_list.length,
                  //       itemBuilder: ((context, index) => ListTile(
                  //         title: Text(display_list[index].Name!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  //       ))),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
