import 'package:chatapp/screens/chat_room_screen/ui/chat_room_screen.dart';
import 'package:flutter/material.dart';

import '../../call_screen/ui/cal_screen.dart';
import '../../contact_screen/ui/contact_screen.dart';
import '../../profile_screen/ui/profile_screen.dart';
import '../../story_screen/ui/story_screen.dart';

class CustomBottomNavigationScreen extends StatefulWidget {
  const CustomBottomNavigationScreen({Key key}) : super(key: key);

  @override
  State<CustomBottomNavigationScreen> createState() => _CustomBottomNavigationScreenState();
}

class _CustomBottomNavigationScreenState extends State<CustomBottomNavigationScreen> {
  int currentIndex = 0;
  final List pages = [
     ChatRoomScreen(),
     CallScreen(),
     StoryScreen(),
     ContactScreen(),
     ProfileScreen()
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        onTap: onTap,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),),

          BottomNavigationBarItem(
            label: 'Call',
            icon: Icon(Icons.call_outlined),
            activeIcon: Icon(Icons.call),),

          BottomNavigationBarItem(
            label: 'Story',
            icon: Icon(Icons.camera_alt_outlined),
            activeIcon: Icon(Icons.camera_alt),),

          BottomNavigationBarItem(
            label: 'Contact',
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),),

          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),),
        ],
      ),
    );
  }
}