import 'package:flutter/material.dart';

import '../screens/search.dart';
class CustomFloatingAddButton extends StatelessWidget {
  const CustomFloatingAddButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(225,157,112,229),
              Colors.blue,
            ],
          )
      ),
      child: Center(
        child: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
            icon: const Icon(Icons.add,color: Colors.white,size: 25,)
        ),
      ),
    );
  }
}
