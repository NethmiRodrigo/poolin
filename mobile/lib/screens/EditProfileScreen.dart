import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/screens/ChangePasswordScreen.dart';
import 'package:mobile/screens/EditBioScreen.dart';
import 'package:mobile/screens/EditFullNameScreen.dart';
import 'package:mobile/screens/EditPersonalDetailsScreen.dart';
import 'package:mobile/services/getuserlogindetails_service.dart';
import 'package:mobile/services/updateprofile_service.dart';
import 'package:mobile/utils/widget_functions.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() {
    return EditProfileScreenState();
  }
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final _storage = const FlutterSecureStorage();
  // late final Response response;

  @override
  void initState() {
    getUserDetails();
    // response = getProfileDetails();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void getUserDetails() async {
    Response response = await getProfileDetails();
    // token = await _storage.read(key: 'TOKEN');
  }

  String dropdownValue = 'Students';
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
        child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(48),
              Form(
                  child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: sidePadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        addHorizontalSpace(16),
                        Text(
                          'Edit Profile',
                          style: Theme.of(context).textTheme.headline3!.merge(
                              const TextStyle(
                                  color: Colors.black, fontSize: 24)),
                        ),
                        Spacer(),
                        // Icon(
                        //   Icons.check,
                        //   color: Colors.black,
                        // ),
                        IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(16),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                              //whatever image you can put here
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Positioned(
                        //     bottom: 0,
                        //     right: 0,
                        //     child: Container(
                        //       height: 40,
                        //       width: 40,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         border: Border.all(
                        //             width: 2,
                        //             color:
                        //                 Theme.of(context).scaffoldBackgroundColor),
                        //         color: Color.fromARGB(255, 230, 124, 25),
                        //       ),
                        //       child: Icon(
                        //         Icons.edit,
                        //         color: Colors.white,
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(
                        top: 10,
                        right: 35,
                        left: 35,
                      )),
                      Text(
                        'Change Profile Photo',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 20,
                        width: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 16,
                          left: 16,
                          bottom: 16,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //     padding: EdgeInsets.only(
                              //   right: 35,
                              //   left: 35,
                              // )),
                              addVerticalSpace(4),

                              Text(
                                'Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                textAlign: TextAlign.left,
                              ),
                              addVerticalSpace(8),
                              TextFormField(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditFullNameScreen()));
                                },
                                key: const Key('name-field'),
                                controller: _name,
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
                                  hintText: "Julianne heignerr",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  }

                                  return null;
                                },
                              ),
                              addVerticalSpace(16),
                              Text(
                                'Bio',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                textAlign: TextAlign.left,
                              ),
                              addVerticalSpace(8),
                              TextFormField(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditBioScreen()));
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                decoration: const InputDecoration(
                                  // labelText: "Bio",
                                  // prefixIcon: Icon(Icons.details_outlined),
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText:
                                      "I'am a person that does things and..",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'bio  is required';
                                  }

                                  return null;
                                },
                              ),

                              addVerticalSpace(16),
                              Text(
                                'Occupation Status',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                textAlign: TextAlign.left,
                              ),
                              addVerticalSpace(8),
                              //////////////////////////////////////////////
                              // DropdownButtonFormField(items: items, onChanged: onChanged)
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  // labelText: "Bio",
                                  // prefixIcon: Icon(Icons.details_outlined),
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Occuption",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                value: dropdownValue,
                                isExpanded: true,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,

                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
                                        const TextStyle(color: Colors.black)),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Students',
                                  'Teachers',
                                  'Others'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              ///////////////////////////////////////

                              addVerticalSpace(24),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditPersonalDetailsScreen()),
                                      );
                                    },
                                    child: Text(
                                      'Personal Information',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(32),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditPersonalDetailsScreen()),
                                      );
                                    },
                                    child: Text(
                                      'Driver Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(32),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangePasswordScreen()),
                                      );
                                    },
                                    child: Text(
                                      'Change Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ]),
                  ),
                ],
              )),

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
