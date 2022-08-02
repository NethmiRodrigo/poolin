// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/custom/mini_button.dart';
import 'package:mobile/utils/widget_functions.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({Key? key}) : super(key: key);

  @override
  UploadDocumentScreenState createState() => UploadDocumentScreenState();
}

class UploadDocumentScreenState extends State<UploadDocumentScreen> {
  TextEditingController textEditingController = TextEditingController();

  /////////////////////////////////////////////////
  File? image;
  //Gallery
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //Camera
  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //build buttons
  // @override
  // Widget buildButton({
  //   required String title,
  //   required IconData icon,
  //   required VoidCallback onClicked,
  // }) =>
  //     ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         minimumSize: Size.fromHeight(56),
  //         primary: Color.fromARGB(255, 0, 0, 0),
  //         onPrimary: Color.fromARGB(255, 255, 255, 255),
  //         textStyle: Theme.of(context).textTheme.bodyText1, 
  //       ),
  //       child: Row(children: [
  //         Icon(
  //           icon,
  //           size: 28,
  //         ),
  //         const SizedBox(width: 16),
  //         Text(title)
  //       ]),
  //       onPressed: onClicked,
  //     );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // addVerticalSpace(48),
                // addVerticalSpace(120),
                addVerticalSpace(120),
                //Image file
                image != null
                    ? Image.file(image!,
                        width: 160, height: 160, fit: BoxFit.cover)
                    : const Icon(Icons.account_box_sharp, size: 110),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'You need to upload your',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    "Driving Lisence",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .merge(const TextStyle(color: Colors.black)),
                  ),
                ),
                // addVerticalSpace(48),

                addVerticalSpace(16),
                // MaterialButton(
                //     color: Colors.black,
                //     child: Text(
                //       "Use Camera",
                //       style: TextStyle(

                //         color: Colors.white70,
                //         // fontWeight: FontWeight.bold
                //       ),
                //     ),
                //     onPressed: () {
                //       pickImageCamera();
                //     }),
                MiniButton(
                    text: 'Use Camera',
                    onPressedAction: () async {
                      pickImageCamera();
                    }),
                // buildButton(
                //     title: 'Use Camera',
                //     icon: Icons.camera_alt_outlined,
                //     onClicked: () => pickImageCamera()),
                addVerticalSpace(16),
                Text(
                  'or',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(16),
                // MaterialButton(
                //     color: Colors.black,
                //     child: Text(
                //       "Upload from Gallery",
                //       style: TextStyle(
                //         color: Colors.white70,
                //         // fontWeight: FontWeight.bold
                //       ),
                //     ),
                //     onPressed: () {
                //       pickImage();
                //     }),
                //Display Image

                MiniButton(
                    text: 'Upload from Gallery',
                    onPressedAction: () async {
                      pickImage();
                    }),
                // buildButton(
                //     title: 'Upload from Gallery',
                //     icon: Icons.image_outlined,
                //     onClicked: () => pickImage()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
