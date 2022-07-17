import 'package:flutter/material.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditDateOfBirthScreen extends StatefulWidget {
  const EditDateOfBirthScreen({super.key});

  @override
  EditDateOfBirthScreenState createState() {
    return EditDateOfBirthScreenState();
  }
}

class EditDateOfBirthScreenState extends State<EditDateOfBirthScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: SizedBox(
        // width: size.width,
        // height: size.height,
        child: GestureDetector(
          // padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    addHorizontalSpace(8),
                    Text(
                      'Edit Date of Birth',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    addHorizontalSpace(72),
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: sidePadding,
                  child: Column(
                      children: [addVerticalSpace(72), SfDateRangePicker()]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
