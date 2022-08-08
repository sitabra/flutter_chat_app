import 'dart:developer';

import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/helper/theme.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'chatrooms.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
    HelperFunctions.saveUserEmailSharedPreference(phoneEditingController.text);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatRoom()));
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
        timeout: Duration(seconds: 10)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: isOtpSent == false
                    ? Column(
                        children: [
                          Spacer(),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: phoneEditingController,
                                  style: simpleTextStyle(),
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val)
                                        ? null
                                        : "Enter correct email";
                                  },
                                  decoration: textFieldInputDecoration("email"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              signUp();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xff007EF4),
                                      const Color(0xff2A75BC)
                                    ],
                                  )),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Sign Up",
                                style: biggerTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Sign Up with Google",
                              style: TextStyle(
                                  fontSize: 17, color: CustomTheme.textColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: simpleTextStyle(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "SignIn now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      )
                    : Column(children: [
                        Spacer(),
                        Form(
                          key: formKey2,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: otpController,
                                style: simpleTextStyle(),
                                decoration:
                                    textFieldInputDecoration("Enter OTP"),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  AuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.getCredential(
                                          verificationId: vId,
                                          smsCode: otpController.text);
                                  signInWithPhoneAuthCredential(
                                      phoneAuthCredential);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xff007EF4),
                                          const Color(0xff2A75BC)
                                        ],
                                      )),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Confirm",
                                    style: biggerTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ])));
  }
}
