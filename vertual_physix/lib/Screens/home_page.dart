import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:virtual_physix/Screens/user_registration.dart';
import '../Services/auth_services.dart';
import 'chapter_page.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userProfilePic = "";
  String userName = "";
  final plyer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    showWelcomeSnackBar();
  }
  void showWelcomeSnackBar() {
    plyer.play(AssetSource('login.wav'));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.withOpacity(0.8),
          content: Text('Logged in Successfully!', style: GoogleFonts.audiowide(fontSize: 15),),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  Future<void> fetchUserData() async {
    // Fetch user data from Firestore
    try {
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      setState(() {
        userProfilePic = userDataSnapshot.get('userProfilePic');
        userName = userDataSnapshot.get('userName');
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height*0.06,
            titleSpacing: 9,
            title: const Text(
                      "Home Page",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
            actions: [
              buildPopupMenuButton(context), // Add your trailing icon button here
            ],
            backgroundColor: Colors.purple,
            centerTitle: true,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 197, 74, 251),
                    Color.fromARGB(255, 23, 15, 54),
                    Color.fromARGB(255, 113, 98, 254)
                  ]
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                FutureBuilder<void>(
                  future: precacheImage(NetworkImage(userProfilePic), context),
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show the loading spinner while the image is being pre-cached
                      return const SpinKitFadingCircle(
                        color: Color.fromARGB(255, 208, 77, 250),
                        size: 70.0,
                      );
                    } else if (snapshot.hasError) {
                      // Handle errors
                      return Text('Error loading image');
                    } else {
                      // Image pre-cached, now show the CircleAvatar
                      return CircleAvatar(
                        backgroundImage: NetworkImage(userProfilePic),
                        radius: 50,
                        backgroundColor: Colors.white70,
                      );
                    }
                  },
                ),

                const SizedBox(height: 10),
                Text(userName != null
                    ? 'Hi ${userName?.split(' ').first}!'
                    : 'Welcome!',
                    style: const TextStyle(color: Colors.white, fontSize: 35)),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 12, // Change itemCount to 10
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            plyer.play(AssetSource('click.wav'));
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const SelectChapterPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.black45,
                            shadowColor: Colors.black45,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // Customize the content of each card as needed
                            child: Center(
                              child: Text(
                                'Class ${12 - index}', // Example content
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  PopupMenuButton<String> buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      color: const Color.fromRGBO(41, 32, 70, 0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: MediaQuery.of(context).size.height * 0.03,
      ),
      onSelected: (String result) {
        plyer.play(AssetSource('click.wav'));
        if (result == 'logout') {
          // Handle the logout action here
          AuthService.signOut();
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text(
            'Log Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

}
