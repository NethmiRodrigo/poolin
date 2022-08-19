import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/screens/user/update-profile/edit_profile_screen.dart';
import 'package:mobile/services/update_profile_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class EditBioScreen extends StatefulWidget {
  const EditBioScreen({super.key});

  @override
  EditBioScreenState createState() {
    return EditBioScreenState();
  }
}

class EditBioScreenState extends State<EditBioScreen> {
  final TextEditingController _bio = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: SizedBox(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(40),
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
                          'Edit Bio',
                          style: Theme.of(context).textTheme.headline3!.merge(
                              const TextStyle(
                                  color: Colors.black, fontSize: 24)),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Map data = {'bio': _bio};
                              String? token = await _storage.read(key: 'TOKEN');
                              Response response =
                                  await updateprofile(data, token!);
                              if (response.statusCode == 200) {
                                if (!mounted) {
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen()),
                                );
                              } else {}
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: sidePadding,
                      child: Column(children: [
                        addVerticalSpace(20),
                        const TextField(
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText:
                                "I am a person that does things and well there is nothing much to say here but random word.  Anyays hope I’vesaid enough",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    addVerticalSpace(32),
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
