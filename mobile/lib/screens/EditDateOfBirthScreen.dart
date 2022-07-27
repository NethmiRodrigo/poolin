import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/services/updateprofile_service.dart';
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
  final _storage = const FlutterSecureStorage();
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
                    Form(child: Row(children: [
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
                    IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                      onPressed: () async{
                        // if (_formKey.currentState!.validate()) {
                        //   String? token = await _storage.read(key: 'TOKEN');
                        //   Response response = await editdateofbirth(
                        //        date, token!);
                        //   if (response.statusCode == 200) {
                        //     if (!mounted) {
                        //       return;
                        //     }
                        //     //replace this with navigation to home page

                        //   } else {}
                        // }
                        Navigator.pop(context);
                      },
                    ),
                    ],))
                    
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
