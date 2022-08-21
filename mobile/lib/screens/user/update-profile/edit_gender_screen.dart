import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/screens/user/update-profile/edit_personal_details_screen.dart';
import 'package:mobile/services/update_profile_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class EditGenderScreen extends StatefulWidget {
  const EditGenderScreen({super.key});

  @override
  EditGenderScreenState createState() {
    return EditGenderScreenState();
  }
}

class EditGenderScreenState extends State<EditGenderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();
  List<bool> isSelected = [true, false];
  String _gender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: GestureDetector(
          child: Column(
            children: [
              addVerticalSpace(48),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          addHorizontalSpace(8),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          addHorizontalSpace(8),
                          Text(
                            'Change Gender',
                            style: Theme.of(context).textTheme.headline3!.merge(
                                const TextStyle(
                                    color: Colors.black, fontSize: 24)),
                          ),
                          addHorizontalSpace(80),
                          IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Map data = {'gender': _gender};
                                String? token =
                                    await _storage.read(key: 'TOKEN');
                                Response response =
                                    await updateprofile(data, token!);
                                if (response.statusCode == 200) {
                                  if (!mounted) {
                                    return;
                                  }
                                  //replace this with navigation to home page

                                } else {}
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditPersonalDetailsScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                      addVerticalSpace(72),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(24),
                            ToggleButtons(
                              onPressed: (int index) {
                                setState(() {
                                  for (int buttonIndex = 0;
                                      buttonIndex < isSelected.length;
                                      buttonIndex++) {
                                    if (buttonIndex == index) {
                                      isSelected[buttonIndex] = true;
                                    } else {
                                      isSelected[buttonIndex] = false;
                                    }
                                  }
                                  if (isSelected[0]) {
                                    _gender = "male";
                                  } else {
                                    _gender = "female";
                                  }
                                });
                              },
                              isSelected: isSelected,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.male_outlined),
                                      addHorizontalSpace(8),
                                      const Text("Male")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.female_outlined),
                                      addHorizontalSpace(8),
                                      const Text("Female")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(40),
                          ]),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
