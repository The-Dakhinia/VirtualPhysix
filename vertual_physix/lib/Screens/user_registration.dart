
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vertual_physix/main.dart';

import '../Services/auth_services.dart';
// import 'package:google_sign_in/google_sign_in.dart';


//login screen -- implements google sign in or sign up feature for app
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    //for auto triggering animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isAnimate = true);
    });
  }
  // Initialize the firebase
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    // _firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {

    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;
    return Scaffold(
      //app bar
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 197, 74, 251),
        automaticallyImplyLeading: false,
        title: const Text('Welcome to VirtualPhysix'),
        centerTitle: true,
      ),

      //body
      body: Stack(children: [
        //app logo
        // Background gradient
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 13, 8, 33)
          ),
        ),
        AnimatedPositioned(
          top: mq.height * 0.25,
          right: _isAnimate ? mq.width * 0.25 : -mq.width * 0.5,
          width: mq.width * 0.5,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Transform.scale(
            scale: 1.7,  // Scale factor of 2 for doubling the size
            child: Image.asset('lib/assets/logo.png'),
          ),
        ),



        //google login button
        Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 208, 77, 250),
                    shape: const StadiumBorder(),
                    elevation: 1,
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async => false, // Disable popping with back button
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: const Color.fromARGB(255, 208, 77, 250),
                            size: 50.0,
                          ),
                        ),
                      );
                    },
                  );
                  await AuthService().signInWithGoogle(context);
                },

                //google icon
                icon: Image.asset('lib/assets/google.png', height: mq.height * .03),

                //login with google label
                label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      children: [
                        TextSpan(text: 'Login with '),
                        TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ]),
                ))),
      ]),
    );
  }
}
