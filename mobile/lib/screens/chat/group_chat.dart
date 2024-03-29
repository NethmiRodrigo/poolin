// ignore_for_file: unrelated_type_equality_checks

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/models/message.dart';
import 'package:poolin/models/user_model.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:poolin/screens/chat/received_msg_widget.dart';
import 'package:poolin/screens/chat/sent_msg_widget.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final int tripID = 845136993;
  final User currentUser = User(
    id: 003,
    firstName: 'Azma',
    lastName: 'Imtiaz',
    gender: 'female',
    email: 'azma@gamil.com',
    profilePicURL: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
  );

  final List<User> participants = [
    User(
      id: 001,
      firstName: 'Nethmi',
      lastName: 'Weerasignhe',
      gender: 'female',
      email: 'neth@gamil.com',
      profilePicURL: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
    ),
    User(
      id: 002,
      firstName: 'Yadeesha',
      lastName: 'Weerasinghe',
      gender: 'female',
      email: 'azma@gamil.com',
      profilePicURL: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
    ),
  ];
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];
  late io.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  Future<void> initSocket() async {
    String? socketServer = dotenv.env['CHAT_SERVER'];

    try {
      socket = io.io(socketServer, <String, dynamic>{
        'transports': ['websocket'],
      });

      // Join the user with username to the room with roomId
      socket.emit("joinRoom", [tripID.toString(), currentUser.firstName]);

      socket.on("sendMessage", (res) {
        if (res['senderID'] != currentUser.id) {
          Message newMessage = Message(
            msg: res['msg'],
            senderID: res['senderID'],
          );
          setState(() {
            messages.add(newMessage);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMessage(int senderID, String msg) {
    Message newMessage = Message(senderID: senderID, msg: msg);

    try {
      var data = {
        'message': {'senderID': senderID, 'msg': msg},
        'room': tripID.toString(),
      };
      socket.emit("sendMessage", data);

      setState(() {
        messages.add(newMessage);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    final Size size = MediaQuery.of(context).size;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(20),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  ),
                ),
              ),
              addVerticalSpace(16),
              Text('Trip ID - $tripID', style: BlipFonts.heading),
              SizedBox(
                height: size.height * 0.12,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: BlipColors.lightGrey,
                            foregroundImage: NetworkImage(
                              participants[index].profilePicURL,
                            ),
                          ),
                          addVerticalSpace(5),
                          Text(
                            participants[index].firstName,
                            style: BlipFonts.tagline,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: participants.length,
                ),
              ),
              Expanded(
                child: Container(
                  color: BlipColors.lightGrey,
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (ctx, index) {
                      if (messages[index].senderID == currentUser.id) {
                        return SentMessage(
                          messages[index].msg,
                        );
                      }
                      String senderName = participants
                          .firstWhere((element) =>
                              element.id == messages[index].senderID)
                          .firstName;
                      return ReceivedMessage(
                        senderName,
                        messages[index].msg,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _messageController,
                        style: BlipFonts.outline,
                        decoration: InputDecoration(
                            hintText: 'Type your message here...',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: BlipColors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: BlipColors.grey),
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                color: BlipColors.orange,
                                onPressed: () {
                                  String msg = _messageController.text;
                                  if (msg.isNotEmpty) {
                                    sendMessage(currentUser.id, msg);
                                    _messageController.clear();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                })),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
