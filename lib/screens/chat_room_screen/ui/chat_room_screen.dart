import 'dart:developer';
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widget/custom_floating_button.dart';
import 'package:flutter/material.dart';
import '../../chat_screen/ui/chat_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.documents[index].data["chatRoomId"],
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 50,right: 15),
                    child: Divider(
                      thickness: 1,
                      indent: 10.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  );
        },)
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        log(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("chatSPACE"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(225,157,112,229),
                  Colors.blue,
                ],
              )
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: CustomFloatingAddButton()
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatScreen(
            userName: userName,
            chatRoomId: chatRoomId,

          )
        ));
      },
      child: ListTile(
        leading: CircleAvatar(
              child: Text(userName.substring(0, 1),style: TextStyle(fontSize: 25),),
            ),
         title: Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))

      ),
    );
  }
}
