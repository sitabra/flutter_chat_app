import 'package:flutter/material.dart';
class StoryScreen extends StatefulWidget {
  const StoryScreen({Key key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Story Screen"),
      ),
    );
  }
}
