import 'package:flutter/material.dart';

List<String> subChapters = [
  "Introduction to Electric Charges and Fields",
  "Electric Charge",
  "Conductors and Insulators",
  "Charging by Induction",
  "Basic Properties of Eletric Charge",
  "Coulomb’s Law",
  "Forces between Multiple Charges",
  "Electric Field",
  "Electric Field Lines",
  "Electric Flux",
  "Electric Dipole",
  "Dipole in a Uniform External Field",
  "Continuous Charge Distribution",
  "Gauss’s Law And Its Applications"
];

class SelectSubChapterPage extends StatefulWidget {
  const SelectSubChapterPage({Key? key}): super(key: key);

  @override
  _SelectSubChapterPageState createState() => _SelectSubChapterPageState();
}

class _SelectSubChapterPageState extends State<SelectSubChapterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor:  Colors.purple,
        title: const Text(
          "Select Sub Chapter ",
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
              colors: [Color.fromARGB(255, 197, 74, 251),
                Color.fromARGB(255, 23, 15, 54),
                Color.fromARGB(255, 113, 98, 254)
              ]
          ),
        ),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: subChapters.length, // Change itemCount to 10
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (context, animation, secondaryAnimation) => const SelectSubChapterPage(),
                    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    //       const begin = Offset(1.0, 0.0);
                    //       const end = Offset.zero;
                    //       const curve = Curves.easeInOut;
                    //
                    //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    //       var offsetAnimation = animation.drive(tween);
                    //
                    //       return SlideTransition(
                    //         position: offsetAnimation,
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  child: Card(
                    color: Colors.black45,
                    shadowColor: Colors.black45,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        subChapters[index],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white,),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}