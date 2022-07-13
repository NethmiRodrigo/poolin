import 'package:flutter/material.dart';
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
                padding: EdgeInsets.all(16.0),
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
                      'Edit Profile',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
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
                height: 16,
              ),
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
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: Color.fromARGB(255, 230, 124, 25),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
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
                    child: Column(children: [
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //   right: 35,
                      //   left: 35,
                      // )),
                      SizedBox(
                        height: 4,
                      ),
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
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
                            'Bio',
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
                        height: 24,
                      ),
                      Row(
                        children: [
                          Text(
                            'Personal Information',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            'Driver Details',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            'Change Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(const TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
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
