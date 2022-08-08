import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() {
    return UserProfileScreenState();
  }
}

class UserProfileScreenState extends State<UserProfileScreen> {
  //build buttons
  @override
  Widget buildButton({
    required String title,
    required IconData icon,
    required IconData icon2,
    required VoidCallback onClicked,
  }) =>
      TextButton(
        style: ElevatedButton.styleFrom(
          // alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),

          // minimumSize: Size.fromHeight(56),
          primary: Color.fromARGB(255, 255, 255, 255),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          // textStyle: Theme.of(context).textTheme.bodyText1,
        ),
        child: Row(children: [
          // Center(),

          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(title),
          Spacer(),
          Icon(
            icon2,
            size: 16,
          ),
        ]),
        onPressed: onClicked,
      );

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(48),
              Container(
                // width: double.infinity,
                // padding: sidePadding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Profile',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(24),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profilePic.jpg"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -10,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            onPressed: () {},
                            child:
                                Image.asset("assets/images/iconverified.png"),
                          ),
                          // child: Icon(Icons.edit,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(4),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Natalia shefnier',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                ),
              ),
              addVerticalSpace(24),
              buildButton(
                  title: 'My Details',
                  icon: FontAwesomeIcons.user,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              addVerticalSpace(16),
              buildButton(
                  title: 'Ride History',
                  icon: FontAwesomeIcons.history,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              addVerticalSpace(16),
              buildButton(
                  title: 'Close Friends',
                  icon: FontAwesomeIcons.userGroup,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              addVerticalSpace(16),
              buildButton(
                  title: 'Friend Request',
                  icon: FontAwesomeIcons.userPlus,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              addVerticalSpace(16),
              buildButton(
                  title: 'Vehicle Information',
                  icon: FontAwesomeIcons.car,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              addVerticalSpace(16),
              buildButton(
                  title: 'Ride Visibility',
                  icon: FontAwesomeIcons.magnifyingGlassLocation,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              addVerticalSpace(16),
              buildButton(
                  title: 'Log Out',
                  icon: FontAwesomeIcons.arrowRightFromBracket,
                  onClicked: () => {},
                  icon2: Icons.arrow_forward_ios),
              //  SizedBox(height:20),
              // Container(
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //     child: Column(
              //       children: [
              //         TextButton(
              //             style: TextButton.styleFrom(
              //               padding: const EdgeInsets.all(16.0),
              //               primary: Color.fromARGB(255, 234, 4, 4),
              //               textStyle: const TextStyle(fontSize: 20),
              //             ),
              //             onPressed: () {},
              //             child: Row(
              //               children: [],
              //             )),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
