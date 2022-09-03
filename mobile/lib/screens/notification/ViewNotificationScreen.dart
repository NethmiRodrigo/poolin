import 'package:flutter/material.dart';

// import 'package:';

class ViewNotificationScreen extends StatefulWidget {
  const ViewNotificationScreen({super.key});

  @override
  ViewNotificationScreenState createState() {
    return ViewNotificationScreenState();
  }
}

class ViewNotificationScreenState extends State<ViewNotificationScreen> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: listView(
          // child: GestureDetector(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       addVerticalSpace(48),
          //       Container(
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             addHorizontalSpace(8),
          //             IconButton(
          //               icon: const Icon(
          //                 Icons.arrow_back,
          //                 color: Colors.black,
          //               ),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //             ),
          //             addHorizontalSpace(8),
          //             Text(
          //               'Notification',
          //               style: Theme.of(context).textTheme.headline3!.merge(
          //                   const TextStyle(color: Colors.black, fontSize: 24)),
          //             ),
          //             addHorizontalSpace(172),
          //           ],
          //         ),
          //       ),

          //       addVerticalSpace(32),
          //       ////////////////////////////////////////
          //     ],
          //   ),
          // ),
          ),
    );
  }

  Widget listView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return listViewItem(index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: 15);
  }

  Widget listViewItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                message(index),
                description(index),
                timeAndDate(index),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey.shade300),
      child: Icon(Icons.notifications,size: 25, color: Colors.grey.shade700,),
    );
  }

  Widget message(int index) {
    double textSize = 14;
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: 'Message',
            style: TextStyle(
                fontSize: textSize,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            ),
      ),
    );
  }

  Widget description(int index) {
    double textSize = 14;
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            // text: 'Message',
            // style: TextStyle(
            //     fontSize: textSize,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: 'description of notification',
                style: TextStyle(fontWeight: FontWeight.w400),
              )
            ]),
      ),
    );
  }

  Widget timeAndDate(int index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          '23-02-2022',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        Text(
          '12:00 am',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ]),
    );
  }
}
