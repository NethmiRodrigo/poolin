import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/message.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/utils/widget_functions.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final int tripID = 845136993;
  final User currentUser = User(
    id: '001',
    firstName: 'Nethmi',
    lastName: 'Pathirana',
    gender: 'female',
    email: 'neth@gamil.com',
    profilePicture: 'https://i.pravatar.cc/300?img=11',
  );
  final List<User> participants = [
    User(
      id: '002',
      firstName: 'Yadeesha',
      lastName: 'Weerasinghe',
      gender: 'female',
      email: 'yadee@gamil.com',
      profilePicture: 'https://i.pravatar.cc/300?img=13',
    ),
    User(
      id: '003',
      firstName: 'Nethmi',
      lastName: 'Rodrigo',
      gender: 'female',
      email: 'neth@gamil.com',
      profilePicture: 'https://i.pravatar.cc/300?img=22',
    ),
  ];
  TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  Future<void> initSocket() async {
    String? socketServer = dotenv.env['SOCKET_SERVER'];

    try {
      socket = IO.io(socketServer, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();

      socket.onConnect((data) => {print('Connect: ${socket.id}')});

      socket.on("chat-message", (data) async {
        var message = Message(
          senderID: data['senderID'],
          msg: data['msg'],
        );
        messages.add(message);
        print('Message: ${message.msg}');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void sendMessage(String senderID, String msg) {
    var message = {'senderID': senderID, 'msg': msg};
    socket.emit('chat-message', message);
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
              addVerticalSpace(24),
              Text('Trip ID - $tripID', style: BlipFonts.heading),
              SizedBox(
                height: size.height * 0.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: BlipColors.lightGrey,
                        foregroundImage: NetworkImage(
                          participants[index].profilePicture,
                        ),
                      ),
                    );
                  },
                  itemCount: participants.length,
                ),
              ),
              Expanded(
                child: Container(
                  color: BlipColors.lightGrey,
                  child: const Text('Chat messages'),
                ),
              ),
              Container(
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
