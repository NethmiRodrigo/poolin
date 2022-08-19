import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/screens/user/update-profile/change_password_screen.dart';
import 'package:mobile/screens/user/update-profile/edit_bio_screen.dart';
import 'package:mobile/screens/user/update-profile/edit_full_name_screen.dart';
import 'package:mobile/screens/user/update-profile/edit_personal_details_screen.dart';
import 'package:mobile/screens/user/update-profile/upload_document_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() {
    return EditProfileScreenState();
  }
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _name = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String dropdownValue = 'Students';
  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(children: <Widget>[
          Form(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: sidePadding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      addHorizontalSpace(16),
                      Text(
                        'Edit Profile',
                        style: Theme.of(context).textTheme.headline3!.merge(
                            const TextStyle(color: Colors.black, fontSize: 24)),
                      ),
                      const Spacer(),
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
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(children: [
                  const Padding(
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
                  const SizedBox(
                    height: 20,
                    width: 50,
                  ),
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
                            'Name',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .merge(const TextStyle(color: Colors.black)),
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
                                .merge(const TextStyle(color: Colors.black)),
                            decoration: const InputDecoration(
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
                                .merge(const TextStyle(color: Colors.black)),
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
                                .merge(const TextStyle(color: Colors.black)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "I'am a person that does things and..",
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
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          addVerticalSpace(8),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
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
                            elevation: 16,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Students', 'Teachers', 'Others']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
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
                                      .merge(
                                          const TextStyle(color: Colors.black)),
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
                                            const UploadDocumentScreen()),
                                  );
                                },
                                child: Text(
                                  'Driver Details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(
                                          const TextStyle(color: Colors.black)),
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
                                      .merge(
                                          const TextStyle(color: Colors.black)),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
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
