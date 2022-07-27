import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/screens/ChangePasswordScreen.dart';
import 'package:mobile/screens/EditBioScreen.dart';
import 'package:mobile/screens/EditPersonalDetailsScreen.dart';
import 'package:mobile/screens/EditProfileScreen.dart';
import 'package:mobile/services/updateprofile_service.dart';
import 'package:mobile/utils/widget_functions.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

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
  final TextEditingController _gender = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _fname.dispose();
    _lname.dispose();
    _gender.dispose();
    super.dispose();
  }

  // String dropdownValue = 'Students';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(key: _formKey,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(48),

              Container(
                // width: double.infinity,
                // padding: sidePadding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    addHorizontalSpace(8),
                    Form(
                        // key: _formKey,
                        child: Row(
                      children: [
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
                              const TextStyle(
                                  color: Colors.black, fontSize: 24)),
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.check,
                        //   color: Colors.black,
                        // ),
                        addHorizontalSpace(132),
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
                              Response response = await updateprofile(
                                  data, token!);
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
                                //replace this with navigation to home page

                              } else {}
                            }
                            // Navigator.pop(context);
                          },
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              addVerticalSpace(16),
              // Center(
              //   child: Stack(
              //     children: [],
              //   ),
              // ),
              Container(
                child: Column(children: [
                  //FOrm ---------------------------->>>>>>>>>>>
                  Padding(
                      padding: EdgeInsets.only(
                    top: 10,
                    right: 35,
                    left: 35,
                  )),
                  Container(
                    margin: EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 16,
                    ),
                    child: Column(children: [
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //   right: 35,
                      //   left: 35,
                      // )),
                      addVerticalSpace(4),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First name',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                textAlign: TextAlign.left,
                              ),
                              addVerticalSpace(8),
                              TextFormField(
                                key: const Key('fname-field'),
                                controller: _fname,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                decoration: const InputDecoration(
                                  // labelText: "Full Name",
                                  // prefixIcon: Icon(Icons.face_outlined),
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
////////////////////////////////////////////////////////////////////////////////////////
                              Text(
                                'Last name',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                textAlign: TextAlign.left,
                              ),
                              addVerticalSpace(8),
                              TextFormField(
                                key: const Key('lname-field'),
                                controller: _lname,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                decoration: const InputDecoration(
                                  // labelText: "Full Name",
                                  // prefixIcon: Icon(Icons.face_outlined),
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
                              //////////////////////////////////////////////////////////
                              addVerticalSpace(16),

                              //////////////////////////////////////////////
                              // DropdownButtonFormField(items: items, onChanged: onChanged)

                              ///////////////////////////////////////
                            ],
                          )),

                      addVerticalSpace(24),
                    ]),
                  ),
                ]),
              ),

              // Container(
              //   color: Colors.blue,
              //   child: Text('Box-2'),
              //   height: 200,
              // ),
            ]),
      ),
    ));
  }
}
