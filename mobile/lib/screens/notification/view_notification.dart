import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/utils/widget_functions.dart';
// import 'package:';

class viewnotiScreen extends StatefulWidget {
  const viewnotiScreen({super.key});

  @override
  viewnotiScreenState createState() {
    return viewnotiScreenState();
  }
}

class viewnotiScreenState extends State<viewnotiScreen> {
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
                      'Notification',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    addHorizontalSpace(172),
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
                        height: 76,
                        width: 72,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 48,
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
                                        'Payment successful',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .merge(const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Text(
                                        'Parking booking at Portley was ..',
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
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '05-09-2022',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .merge(const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10)),
                                      ),
                                    ],
                                  ),

                                  Spacer(),
                                  Text(
                                    '12:00 am',
                                    style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .merge(const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10)),
                                  ),
                                ],
                              ),
                              // addHorizontalSpace(10),
                              SizedBox(
                                width: 16,
                              ),
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
