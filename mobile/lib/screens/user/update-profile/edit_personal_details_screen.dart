import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/screens/user/update-profile/edit_date_of_birth_screen.dart';
import 'package:poolin/screens/user/update-profile/edit_gender_screen.dart';
import 'package:poolin/screens/user/update-profile/edit_phone_number_screen.dart';
import 'package:poolin/utils/widget_functions.dart';

class EditPersonalDetailsScreen extends StatefulWidget {
  const EditPersonalDetailsScreen({super.key});

  @override
  EditPersonalDetailsScreenState createState() {
    return EditPersonalDetailsScreenState();
  }
}

class EditPersonalDetailsScreenState extends State<EditPersonalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    CurrentUserCubit currentUser = BlocProvider.of<CurrentUserCubit>(context);
    return Scaffold(
        body: SizedBox(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(children: <Widget>[
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
                'Personal Information',
                // style: TextStyle(color: Colors.black87, fontSize: 25),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .merge(const TextStyle(color: Colors.black, fontSize: 24)),
              ),
              const Spacer(),
            ],
          ),
          addVerticalSpace(48),
          Column(children: [
            Container(
              margin: const EdgeInsets.only(
                right: 16,
                left: 16,
              ),
              child: Column(children: [
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        textAlign: TextAlign.left,
                      ),
                      addVerticalSpace(4),
                      TextFormField(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditGenderScreen()));
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Male",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gender is required';
                          }

                          return null;
                        },
                      ),
                      addVerticalSpace(8),
                      Text(
                        'Phone Number',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        textAlign: TextAlign.left,
                      ),
                      addVerticalSpace(4),
                      TextFormField(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditPhoneNumberScreen()));
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "077522369",
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
                      addVerticalSpace(8),
                      Text(
                        'Date of Birth',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        textAlign: TextAlign.left,
                      ),
                      addVerticalSpace(4),
                      TextFormField(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditDateOfBirthScreen()));
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "09/06/1999",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Occupation Status is requied';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ]),
      ),
    ));
  }
}
