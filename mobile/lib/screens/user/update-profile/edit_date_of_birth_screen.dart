import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: SizedBox(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(48),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                            'Edit Date of Birth',
                            style: Theme.of(context).textTheme.headline3!.merge(
                                const TextStyle(
                                    color: Colors.black, fontSize: 24)),
                          ),
                          addHorizontalSpace(72),
                          IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                          /////this is
                        ],
                      ),
                      Padding(
                        padding: sidePadding,
                        child: Column(children: [
                          addVerticalSpace(72),
                          SfDateRangePicker()
                        ]),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
