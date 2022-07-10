import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Details Screen',
      theme: AppTheme().themeData,
      home: const RegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<bool> isSelected = [false, true];
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(48),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'STEP 5/5',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Image.asset('assets/images/logo.png', scale: 3),
                Text(
                  "You're almost there!",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .merge(TextStyle(color: Colors.black)),
                  textAlign: TextAlign.left,
                ),
                addVerticalSpace(48),
                const TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                )),
                addVerticalSpace(24),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Last Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
                addVerticalSpace(24),
                ToggleButtons(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(Icons.male_outlined),
                          addHorizontalSpace(8),
                          Text("Male")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(Icons.female_outlined),
                          addHorizontalSpace(8),
                          Text("Female")
                        ],
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
                addVerticalSpace(40),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(50),
                      textStyle: Theme.of(context).textTheme.bodyText1),
                  onPressed: () {},
                  child: const Text('Start Pooling!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
