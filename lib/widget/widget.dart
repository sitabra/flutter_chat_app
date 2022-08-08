import 'package:flutter/material.dart';
import '../screens/custom_bottom_navigation_screen/ui/custom_bottom_navigation_screen.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => CustomBottomNavigationScreen()
                  ));
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          CircleAvatar(
            radius: 15,
          )
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.videocam_rounded)),
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.call)),
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert)),
    ],
    title: Text("chatSPACE"),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(225, 157, 112, 229),
          Colors.blue,
        ],
      )),
    ),
    elevation: 0.0,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
