// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/user/update-profile/edit_profile_screen.dart';

import 'package:mobile/services/change_password_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ChangePasswordScreenState createState() {
    return ChangePasswordScreenState();
  }
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentpass = TextEditingController();
  final TextEditingController _newpass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _newpass.dispose();
    _currentpass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SizedBox(
        // width: size.width,
        // height: size.height,
        child: GestureDetector(
          // padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(48),
              Container(
                // width: double.infinity,
                // padding: sidePadding,
                child: Row(
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
                    //////
                    addHorizontalSpace(8),
                    Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
              addVerticalSpace(48),
              // addVerticalSpace(48),
              Container(
                child: Padding(
                  padding: sidePadding,
                  child: Column(children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            key: const Key('currentpassword-field'),
                            controller: _currentpass,
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: 'Enter current password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return 'Password length must be atleast 8 characters';
                              }
                              return null;
                            },
                          ),
                          addVerticalSpace(24),
                          TextFormField(
                            key: const Key('newpassword-field'),
                            controller: _newpass,
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: 'Enter new password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return 'Password length must be atleast 8 characters';
                              }
                              return null;
                            },
                          ),
                          addVerticalSpace(24),
                          TextFormField(
                            key: const Key('confirm-password-field'),
                            controller: _confirmPass,
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: 'Confirm new password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                            validator: (value) {
                              if ((value == null || value.isEmpty) &&
                                  !(_newpass.text == null ||
                                      _newpass.text.isEmpty)) {
                                return 'Please re-enter your password';
                              } else if (value != _newpass.text) {
                                return 'Passwords do not match';
                              }

                              return null;
                            },
                          ),
                          addVerticalSpace(40),
                          WideButton(
                              text: 'Reset Password',
                              onPressedAction: () async {
                                if (_formKey.currentState!.validate()) {
                                  String? token =
                                      await _storage.read(key: 'TOKEN');
                                  Response response = await changepassword(
                                      _currentpass.text,
                                      _newpass.text,
                                      _confirmPass.text,
                                      token!);
                                  if (!mounted) {
                                    return;
                                  }
                                  if (response.statusCode == 200) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditProfileScreen()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Error: ${response.body}')),
                                    );
                                  }
                                }
                              }),
                          addVerticalSpace(16),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
