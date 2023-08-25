import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chapter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userProfilePic = ""; // Store user profile picture URL
  String userName = ""; // Store user name

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the widget initializes
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
        titleSpacing: 9,
        title: const Text(
          "Home Page",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.black]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: NetworkImage(userProfilePic), // Set user profile picture
              radius: 50,
              backgroundColor: Colors.white70,
            ),
            const SizedBox(height: 10),
            Text(userName != null
                ? 'Hi ${userName?.split(' ').first}!'
                : 'Welcome!',
                style: TextStyle(color: Colors.white, fontSize: 35)),
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
                        // Navigate to the next page with the selected chapter
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectChapterPage(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.deepPurple[400],
                        elevation: 5,
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
                              fontWeight: FontWeight.bold,
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
}
