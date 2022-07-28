import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile/screens/EditDateOfBirthScreen.dart';
import 'package:mobile/screens/EditGenderScreen.dart';
import 'package:mobile/screens/EditPhoneNumberScreen.dart';
import 'package:mobile/utils/widget_functions.dart';

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
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // TODO: implement build
    return Scaffold(
        body: SizedBox(
      // width: size.width,
      // height: size.height,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
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
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // SizedBox(
                    //   width: 16,
                    // ),
                    addHorizontalSpace(8),
                    Text(
                      'Personal Information',
                      // style: TextStyle(color: Colors.black87, fontSize: 25),
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              addVerticalSpace(48),
              Container(
                child: Column(children: [
                  // Padding(
                  //     padding: EdgeInsets.only(
                  //         // top: 10,
                  //         // right: 35,
                  //         // left: 35,
                  //         )),
                  // Text(
                  //   'Change Profile Photo',
                  //   style: TextStyle(color: Colors.black87, fontSize: 16),
                  //   textAlign: TextAlign.center,
                  // ),
                  // Container(
                  //   height: 20,
                  //   width: 50,
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 16,
                      left: 16,
                      // bottom: 10,
                    ),
                    child: Column(children: [
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //   right: 35,
                      //   left: 35,
                      // )),
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
                          // SizedBox(
                          //   height: 4,
                          // ),
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

                          // SizedBox(
                          //   height: 8,
                          // ),
                          addVerticalSpace(8),
                          Text(
                            'Phone Number',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          // SizedBox(
                          //   height: 4,
                          // ),
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
                              // labelText: "Bio",
                              // prefixIcon: Icon(Icons.details_outlined),
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
                          // TextField(
                          //   decoration: InputDecoration(
                          //       labelText: "Bio",
                          //       floatingLabelBehavior: FloatingLabelBehavior.always,
                          //       // border: OutlineInputBorder(
                          //       //     borderRadius: BorderRadius.circular(4)),
                          //       hintText: "I'am a person that does things and..",
                          //       hintStyle: TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.black,
                          //       )),
                          // ),
                          /////////////////////////
                          // SizedBox(
                          //   height: 8,
                          // ),
                          addVerticalSpace(8),
                          Text(
                            'Date of Birth',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          // SizedBox(
                          //   height: 4,
                          // ),
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
                              // labelText: "Occupation Status",
                              // prefixIcon: Icon(Icons.biotech_outlined),
                              border: OutlineInputBorder(),

                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(4)),
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
                      )),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // addVerticalSpace(16),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      // addVerticalSpace(40),
                    ]),
                  ),
                ]),
              ),
            ]),
      ),
    ));
  }
}
