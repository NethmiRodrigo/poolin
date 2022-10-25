// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/app.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/screens/forgot-password/forgot_password_screen.dart';
import 'package:poolin/services/complaint_service.dart';
import 'package:poolin/services/login_service.dart';
import 'package:poolin/utils/widget_functions.dart';

import '../../colors.dart';
import '../../cubits/current_user_cubit.dart';
import '../../fonts.dart';

class ComplaintScreen extends StatefulWidget {
  ComplaintScreen(
      {super.key,
      required this.name,
      required this.userId,
      required this.avatar});
  late int userId;
  late String avatar;
  late String name;

  @override
  ComplaintScreenState createState() {
    return ComplaintScreenState();
  }
}

class ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _complaint = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    AuthStateCubit authState = BlocProvider.of<AuthStateCubit>(context);
    final CurrentUserCubit userCubit =
        BlocProvider.of<CurrentUserCubit>(context);
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(44),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(32),
              const Text(
                "Issue Complaint",
                style: BlipFonts.title,
                textAlign: TextAlign.left,
              ),
              addVerticalSpace(32),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Re:",
                          style: BlipFonts.outlineBold,
                        ),
                        addHorizontalSpace(8),
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(widget.avatar),
                        ),
                        addHorizontalSpace(8),
                        Text(
                          widget.name,
                          style: BlipFonts.outline,
                        ),
                      ],
                    ),
                    addVerticalSpace(24),
                    TextFormField(
                      minLines: 8,
                      maxLines: 10,
                      style: Theme.of(context).textTheme.labelLarge,
                      controller: _complaint,
                      decoration: const InputDecoration(
                        hintText: 'Tell us what happened',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }

                        return null;
                      },
                    ),
                    addVerticalSpace(24),
                    addVerticalSpace(10),
                    addVerticalSpace(32),
                    WideButton(
                        text: 'File Complaint',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Response response = await reportUser(
                                _complaint.text,
                                int.parse(userCubit.state.id),
                                4,
                                widget.userId);

                            if (response.statusCode == 200) {
                              if (!mounted) {
                                return;
                              }
                              authState.setLoggedIn(true);
                              Navigator.pop(context);
                            } else {}
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
