import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:poolin/screens/user/update-profile/edit_profile_screen.dart';
import 'package:poolin/services/update_profile_service.dart';
import 'package:poolin/utils/widget_functions.dart';

class EditFullNameScreen extends StatefulWidget {
  const EditFullNameScreen({super.key});

  @override
  EditFullNameScreenState createState() {
    return EditFullNameScreenState();
  }
}

class EditFullNameScreenState extends State<EditFullNameScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _fname.dispose();
    _lname.dispose();
    super.dispose();
  }

  // String dropdownValue = 'Students';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        child: Column(children: <Widget>[
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
                      'Edit Name',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map data = {
                            'firstname': _fname.text,
                            'lastname': _lname.text,
                          };
                          String? token = await _storage.read(key: 'TOKEN');
                          Response response = await updateprofile(data, token!);
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
                addVerticalSpace(16),
                Column(children: [
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 10,
                    right: 35,
                    left: 35,
                  )),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 16,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addVerticalSpace(4),
                          Text(
                            'First name',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          addVerticalSpace(8),
                          TextFormField(
                            key: const Key('fname-field'),
                            controller: _fname,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Julianne",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name is required';
                              }

                              return null;
                            },
                          ),
                          addVerticalSpace(16),
                          Text(
                            'Last name',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          addVerticalSpace(8),
                          TextFormField(
                            key: const Key('lname-field'),
                            controller: _lname,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "heignerr",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lastname is required';
                              }

                              return null;
                            },
                          ),
                          addVerticalSpace(16),
                          addVerticalSpace(24),
                        ]),
                  ),
                ]),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
