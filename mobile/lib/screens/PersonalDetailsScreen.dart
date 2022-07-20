import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  PersonalDetailsScreenState createState() {
    return PersonalDetailsScreenState();
  }
}

class PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final _storage = const FlutterSecureStorage();
  List<bool> isSelected = [true, false];
  String _gender = "male";

  @override
  void dispose() {
    _fname.dispose();
    _lname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(48),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'STEP 5/5',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Image.asset('assets/images/logo.png', scale: 3),
              Text(
                "You're almost there!",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .merge(const TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
              ),
              addVerticalSpace(48),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _fname,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'First Name',
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        } else if (value.length > 20) {
                          return 'Name length cannot be more than 20 characters';
                        }

                        return null;
                      },
                    ),
                    addVerticalSpace(24),
                    TextFormField(
                      controller: _lname,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Last Name',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        } else if (value.length > 20) {
                          return 'Name length cannot be more than 20 characters';
                        }
                        return null;
                      },
                    ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.male_outlined),
                              addHorizontalSpace(8),
                              const Text("Male")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    WideButton(
                      text: 'Start Pooling!',
                      onPressedAction: () async {
                        if (_formKey.currentState!.validate()) {
                          String? email = await _storage.read(key: 'KEY_EMAIL');
                          Response response = await submitPersonalDetails(
                              _fname.text, _lname.text, _gender, email);
                          if (response.statusCode == 200) {
                            if (!mounted) {
                              return;
                            }
                            //replace this with navigation to home page

                          } else {}
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
