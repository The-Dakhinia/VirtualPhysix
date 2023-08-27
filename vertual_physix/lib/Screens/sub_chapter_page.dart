import 'package:flutter/material.dart';
import 'package:virtual_physix/Screens/com_ar.dart';
import 'package:virtual_physix/Screens/space_ar.dart';
import 'package:virtual_physix/Screens/uint_ar.dart';

class SelectSubChapterPage extends StatefulWidget {
  const SelectSubChapterPage({Key? key}) : super(key: key);

  @override
  _SelectSubChapterPageState createState() => _SelectSubChapterPageState();
}

class _SelectSubChapterPageState extends State<SelectSubChapterPage> {

  final List<String> subChapters = [
    "Conservation of Momentum",
    "Visualize Solar System",
    "Play With 3D object",
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
        backgroundColor: Colors.purple,
        title: const Text(
          "Select Concept",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 197, 74, 251),
                    Color.fromARGB(255, 23, 15, 54),
                    Color.fromARGB(255, 113, 98, 254),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: subChapters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        switch (subChapters[index]) {
                          case "Conservation of Momentum":
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ARScreen1(),
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
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
                            break;
                          case "Visualize Solar System":
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ARScreen2(),
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
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
                            break;
                          case "Play With 3D object":
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ARScreen3(),
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
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
                            break;
                        // Add cases for other sub-chapters as needed
                        }
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
