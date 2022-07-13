import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Personal Information',
                      // style: TextStyle(color: Colors.black87, fontSize: 25),
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    Spacer(),
                    // Icon(
                    //   Icons.check,
                    //   color: Colors.black,
                    // ),
                  ],
                ),
              ),
              Container(
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(
                          // top: 10,
                          // right: 35,
                          // left: 35,
                          )),
                  // Text(
                  //   'Change Profile Photo',
                  //   style: TextStyle(color: Colors.black87, fontSize: 16),
                  //   textAlign: TextAlign.center,
                  // ),
                  Container(
                    height: 20,
                    width: 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 10,
                    ),
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(
                        right: 35,
                        left: 35,
                      )),
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
                          SizedBox(
                            height: 4,
                          ),
                          TextFormField(
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
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Phone Number',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextFormField(
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
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Occupation Status',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextFormField(
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
                              hintText: "Student",
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
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
                  ),
                ]),
              ),
            ]),
      ),
    ));
  }
}
