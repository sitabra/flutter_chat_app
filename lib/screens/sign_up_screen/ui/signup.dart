import 'dart:developer';

import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../custom_bottom_navigation_screen/ui/custom_bottom_navigation_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  AuthService authService = new AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isLoading = false;
  bool isOtpSent = false;
  String vId;

  void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
    log("sitabra$phoneAuthCredential");
    setState(() {
      isLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print("sitabra2 ${authCredential.user.phoneNumber}");
      }
      if (kDebugMode) {
        print("sitabra3 ${authCredential.user.uid}");
      }

      setState(() {
        isLoading = false;
      });

      if (authCredential.user != null) {
        if (authCredential.user.phoneNumber != null) {
          createUserId();
        }
      }
    } on AuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  createUserId() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> userDataMap = {
      "userName": phoneEditingController.text,
      "userEmail": phoneEditingController.text
    };

    databaseMethods.addUserInfo(userDataMap);

    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(phoneEditingController.text);
    HelperFunctions.saveUserPhoneSharedPreference(phoneEditingController.text);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CustomBottomNavigationScreen()));
  }

  signUp() async {
    setState(() {
      isLoading = true;
    });
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneEditingController.text,
        verificationCompleted: (phoneAuthCredential) async {
          log("here1");
          log("here$phoneAuthCredential");
          setState(() {
            isLoading = false;
          });
        },
        verificationFailed: (verificationFailed) async {
          if (kDebugMode) {
            print("here2");
          }
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(verificationFailed.message.toString())));
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          if (kDebugMode) {
            print("here4");
          }
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          if (kDebugMode) {
            print("here3");
          }
          setState(() {
            isOtpSent = true;
            isLoading = false;
            vId = verificationId;
            if (kDebugMode) {
              print(vId.toString());
            }
          });
        },
        timeout: Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue, Color.fromARGB(225, 157, 112, 229)],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    color: Colors.transparent,
                    child: isOtpSent == false
                        ? Column(
                            children: [
                              Image.asset(
                                "assets/images/icons.png",
                                height: 350,
                              ),
                              const Text("chatSPACE", style: TextStyle(fontSize: 40),
                              ),
                              Card(
                                child: Column(
                                  children: [
                                Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: phoneEditingController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(),
                                        labelText: 'Phone number',
                                        hintText: 'Enter Your Phone number',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          signUp();
                                        },
                                        child: const Text(
                                          "LOG IN",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ),
                                ),
                                  ]
                                ),
                              )
                            ],
                          )
                        : Column(
                      children: [
                        Image.asset(
                          "assets/images/icons.png",
                          height: 350,
                        ),
                        const Text("chatSPACE", style: TextStyle(fontSize: 40),
                        ),
                        Card(
                          child: Column(
                              children: [
                                Form(
                                  key: formKey2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: TextField(
                                      keyboardType: TextInputType.numberWithOptions(),
                                      controller: otpController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'OTP',
                                        hintText: 'Enter Your OTP')
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          AuthCredential phoneAuthCredential =
                                          PhoneAuthProvider.getCredential(
                                              verificationId: vId,
                                              smsCode: otpController.text);
                                          signInWithPhoneAuthCredential(
                                              phoneAuthCredential);
                                        },
                                        child: const Text(
                                          "Verify",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ),
                                )]),
                        )
                      ],
                    )),
              )),
    );
  }
}
