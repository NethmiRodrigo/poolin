import 'package:poolin/models/mutual_friends.dart';
import 'package:flutter/material.dart';
import 'package:poolin/screens/user/profile/user_profile_screen.dart';
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
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfileScreen()));
                },
              ),
              const Text(
                "Close friends",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
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
                  hintText: "Who are you looking for?",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: display_list.length,
                    itemBuilder: ((context, index) => ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          title: Text(
                            display_list[index].Name!,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          subtitle: Text(
                            display_list[index].position!,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                          trailing: Text(display_list[index].Seemore!),
                          leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                  display_list[index].friendimageurl!)),
                        ))),
              )
            ]),
      ),
    );
  }
}
