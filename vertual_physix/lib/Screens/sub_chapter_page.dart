import 'package:audioplayers/audioplayers.dart';
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
    "Basic Properties of Electric Charge",
    "Coulomb’s Law",
    "Forces between Multiple Charges",
    "Electric Field",
    "Electric Field Lines",
    "Electric Flux",
    "Electric Dipole",
    "Continuous Charge Distribution",
    "Gauss’s Law And Its Applications"
  ];

  final List<String> subChapterImages = [
    'assets/vector/subchapter/subch1.png',
    'assets/vector/subchapter/subch2.png',
    'assets/vector/subchapter/subch3.png',
    'assets/vector/subchapter/subch4.png',
    'assets/vector/subchapter/subch5.png',
    'assets/vector/subchapter/subch6.png',
    'assets/vector/subchapter/subch7.png',
    'assets/vector/subchapter/subch8.png',
    'assets/vector/subchapter/subch9.png',
    'assets/vector/subchapter/subch10.png',
    'assets/vector/subchapter/subch11.png',
    'assets/vector/subchapter/subch12.png',
    'assets/vector/subchapter/subch13.png',
  ];
  final plyer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            plyer.play(AssetSource('click.wav'));
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
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 13,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        plyer.play(AssetSource('click.wav'));
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                            const ARScreen1(),
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
                      },
                      child: Card(
                          color: Colors.black45,
                          shadowColor: Colors.black45,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    subChapterImages[index],
                                    width: 100, // Adjust the size as needed
                                    height: 100,
                                    fit: index == 2 ? BoxFit.cover : index == 10? BoxFit.fill : BoxFit.contain,
                                  ),
                                  Text(
                                    subChapters[index],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                          )
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
