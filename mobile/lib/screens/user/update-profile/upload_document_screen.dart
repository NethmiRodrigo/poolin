import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/utils/widget_functions.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({Key? key}) : super(key: key);

  @override
  UploadDocumentScreenState createState() => UploadDocumentScreenState();
}

class UploadDocumentScreenState extends State<UploadDocumentScreen> {
  TextEditingController textEditingController = TextEditingController();

  File? image;

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
  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          primary: Colors.black,
          onPrimary: Colors.white,
          textStyle: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: onClicked,
        child: Row(children: [
          const SizedBox(width: 16),
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(title)
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 64;
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
                addVerticalSpace(120),
                image != null
                    ? Image.file(image!,
                        width: 160, height: 160, fit: BoxFit.cover)
                    : const Icon(Icons.upload_file_outlined, size: 110),
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
                        .headline4!
                        .merge(const TextStyle(color: Colors.black)),
                  ),
                ),
                addVerticalSpace(16),
                buildButton(
                    title: 'Use Camera',
                    icon: Icons.camera_alt_outlined,
                    onClicked: () => pickImageCamera()),
                addVerticalSpace(16),
                Text(
                  'or',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(16),
                buildButton(
                    title: 'Upload from Gallery',
                    icon: Icons.image_outlined,
                    onClicked: () => pickImage()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
