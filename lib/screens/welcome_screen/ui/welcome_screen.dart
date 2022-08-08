import 'package:chatapp/screens/sign_up_screen/ui/signup.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  final Function toggleView;

  WelcomeScreen(this.toggleView);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Color.fromARGB(225,157,112,229)
            ],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/icons.png", height: 300,),
                ),
                const Text("Hi there!",style: TextStyle(fontSize: 30),),
                const SizedBox(
                  height: 25,
                ),
                const Text("Welcome to",style: TextStyle(fontSize: 20),),
                const Text("chatSPACE",style: TextStyle(fontSize: 40),),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70, bottom: 150),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => SignUpScreen()
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "Let's chat",
                        style: TextStyle(fontSize: 25,
                            color: Color.fromARGB(
                              255,
                              92,
                              139,
                              255,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
