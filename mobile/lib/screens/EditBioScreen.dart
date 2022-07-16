import 'package:flutter/material.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/utils/widget_functions.dart';

class EditBioScreen extends StatefulWidget {
  const EditBioScreen({super.key});

  @override
  EditBioScreenState createState() {
    return EditBioScreenState();
  }
}

class EditBioScreenState extends State<EditBioScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(48),
              Container(
                width: double.infinity,
                padding: sidePadding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    addHorizontalSpace(16),
                    Text(
                      'Edit Bio',
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
              Container(
                margin: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  // bottom: 64,
                ),
                child: Column(children: [
                  ////////////
                  // SizedBox(
                  //   height: 64,
                  // ),
                  addVerticalSpace(64),
                  TextField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(4)),
                        hintText:
                            "I am a person that does things and well there is nothing much to say here but random word.  Anyays hope I’vesaid enough",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ),
                ]),
              ),
              addVerticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }
}
