import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

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
                      style: TextStyle(color: Colors.black87, fontSize: 25),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(
                    top: 10,
                    right: 35,
                    left: 35,
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
                      SizedBox(
                        height: 4,
                      ),
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            decoration: const InputDecoration(
                              labelText: "Gender",
                              prefixIcon: Icon(Icons.face_outlined),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // hintText: "Julianne heignerr",
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
                          )
                        ],
                      )),
                      Text(
                            'Gender',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.details_outlined),
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Number  is required';
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
                        height: 16,
                      ),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        decoration: const InputDecoration(
                          labelText: "Date of birth",
                          prefixIcon: Icon(Icons.biotech_outlined),
                          border: OutlineInputBorder(),

                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(4)),

                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of birth is requied';
                          }

                          return null;
                        },
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
