import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/utils/widget_functions.dart';
// import 'package:';

class ClosefriendScreen extends StatefulWidget {
  const ClosefriendScreen({super.key});

  @override
  ClosefriendScreenState createState() {
    return ClosefriendScreenState();
  }
}

class ClosefriendScreenState extends State<ClosefriendScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: Container(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(48),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    addHorizontalSpace(8),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    addHorizontalSpace(8),
                    Text(
                      'Close friends',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    addHorizontalSpace(156),
                    // ListView(
                    //   // children: [],
                    // ),
                  ],
                ),
              ),
              ////////////////////////////
              // Container(),
              // Container(
              //   margin: EdgeInsets.all(10),
              //   child: RichText(
              //     maxLines: 3,
              //     overflow: TextOverflow.ellipsis,
              //     text: TextSpan(
              //       text: 'Today',
              //       style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              Container(
                child: Column(children: [
                  // prefixIcon(),
                  // Container(),
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: 400,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Container(
                        height: 72,
                        width: 72,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.notifications,
                                  //   color: Color.fromARGB(255, 0, 0, 0),
                                  //   size: 48,
                                  // ),
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //     width: 1,
                                      //     color: Theme.of(context)
                                      //         .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  ///////////////////////
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dulaj prabash',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .merge(const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Text(
                                        'Lecture',
                                        // textAlign: TextAlign.left,
                                        // style: TextStyle(
                                        //   color: Color.fromARGB(255, 0, 0, 0),
                                        // ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .merge(const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                      // SizedBox(
                                      //   height: 8,
                                      // ),
                                      // Text(
                                      //   '05-09-2022',
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodySmall!
                                      //       .merge(const TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: 10)),
                                      // ),
                                      // OutlineButton(
                                      //   onPressedAction: () {},
                                      //   color: BlipColors.black,
                                      //   text: "All",
                                      // ),
                                      
                                    ],
                                  ),

                                  Spacer(),

                                  // Text(
                                  //   '12:00 am',
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .bodySmall!
                                  //       .merge(const TextStyle(
                                  //           color: Colors.black, fontSize: 10)),
                                  // ),
                                  OutlineButton(
                                        onPressedAction: () {},
                                        color: BlipColors.black,
                                        text: "See Profile",
                                      ),
                                ],
                              ),
                              // addHorizontalSpace(10),
                              // SizedBox(
                              //   width: 16,
                              // ),
                            ]),
                        color: Color.fromARGB(255, 243, 243, 243),
                      ),
                    ),
                  )
                ]),
              ),
              ////////////////////////////////
              // Container(
              //   margin: EdgeInsets.all(10),
              //   child: RichText(
              //     maxLines: 3,
              //     overflow: TextOverflow.ellipsis,
              //     text: TextSpan(
              //       text: 'Yesterday',
              //       style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              // Container(
              //   child: Column(children: [
              //     // prefixIcon(),
              //     // Container(),
              //     SizedBox(
              //       height: 160,
              //       child: ListView.builder(
              //         itemCount: 4,
              //         scrollDirection: Axis.vertical,
              //         itemBuilder: (context, index) => Container(
              //           height: 72,
              //           width: 72,
              //           margin: EdgeInsets.all(10),
              //           padding: EdgeInsets.all(8),
              //           child: Column(
              //             // crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //             Row(
              //               children: [

              //                 Icon(
              //                   Icons.notifications,
              //                   color: Color.fromARGB(255, 0, 0, 0),
              //                   size: 48,
              //                 ),
              //                 SizedBox(width: 16,),
              //                 ///////////////////////
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                   Text(
              //                   'Parking booking canceled',
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Color.fromARGB(255, 0, 0, 0),
              //                   ),
              //                 ),
              //                   Text(
              //                   'You have canceled parking at ... ',
              //                   // textAlign: TextAlign.left,
              //                   style: TextStyle(
              //                     color: Color.fromARGB(255, 0, 0, 0),
              //                   ),
              //                 ),
              //                 ],),

              //                 Spacer(),
              //                 Text(
              //               '12:00 am',
              //               style: TextStyle(
              //                 fontSize: 10,
              //               ),
              //             ),

              //               ],
              //             ),
              //             // addHorizontalSpace(10),
              //             SizedBox(width: 16,),

              //           ]),
              //           color: Color.fromARGB(255, 243, 243, 243),
              //         ),
              //       ),
              //     )
              //   ]),
              // ),
              //////////////////////////////
              // Container(
              //   margin: EdgeInsets.all(10),
              //   child: RichText(
              //     maxLines: 3,
              //     overflow: TextOverflow.ellipsis,
              //     text: TextSpan(
              //       text: 'August 24 2022',
              //       style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              // Container(
              //   child: Column(children: [
              //     // prefixIcon(),
              //     // Container(),
              //     SizedBox(
              //       height: 160,
              //       child: ListView.builder(
              //         itemCount: 4,
              //         scrollDirection: Axis.vertical,
              //         itemBuilder: (context, index) => Container(
              //           height: 72,
              //           width: 72,
              //           margin: EdgeInsets.all(10),
              //           padding: EdgeInsets.all(8),
              //           child: Column(
              //             // crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //             Row(
              //               children: [

              //                 Icon(
              //                   Icons.notifications,
              //                   color: Color.fromARGB(255, 0, 0, 0),
              //                   size: 48,
              //                 ),
              //                 SizedBox(width: 16,),
              //                 ///////////////////////
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                   Text(
              //                   'Verification successful',
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Color.fromARGB(255, 0, 0, 0),
              //                   ),
              //                 ),
              //                   Text(
              //                   'You have canceled parking at ... ',
              //                   // textAlign: TextAlign.left,
              //                   style: TextStyle(
              //                     color: Color.fromARGB(255, 0, 0, 0),
              //                   ),
              //                 ),
              //                 ],),

              //                 Spacer(),
              //                 Text(
              //               '12:00 am',
              //               style: TextStyle(
              //                 fontSize: 10,
              //               ),
              //             ),

              //               ],
              //             ),
              //             // addHorizontalSpace(10),
              //             SizedBox(width: 16,),

              //           ]),
              //           color: Color.fromARGB(255, 243, 243, 243),
              //         ),
              //       ),
              //     )
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
