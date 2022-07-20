import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/utils/widget_functions.dart';

class RideRequestDetailsScreen extends StatefulWidget {
  const RideRequestDetailsScreen({super.key});

  @override
  RideRequestDetailsScreenState createState() {
    return RideRequestDetailsScreenState();
  }
}

class RideRequestDetailsScreenState extends State<RideRequestDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      bottomSheet: Container(
        padding: sidePadding,
        height: size.height * 0.5,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(24),
            Text(
              'Confirm your Offer',
              style: Theme.of(context).textTheme.headline5,
            ),
            addVerticalSpace(40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            addVerticalSpace(16),
            WideButton(
                text: "I'll depart at 4.00PM in 2 days", onPressedAction: () {})
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/map.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: const Padding(
            padding: sidePadding,
          ),
        ),
      ),
    );
  }
}
