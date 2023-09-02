import 'package:flutter/material.dart';
import 'sub_chapter_page.dart';

List<String> chapters = [
  "Newton's Laws of Motion",
  "Electrostatic Potential and Capacitance",
  "Current Electricity",
  "Moving Charges and Magnetism",
  "Magnetism and Matter",
  "Electromagnetic Induction",
  "Alternating Current",
  "Electromagnetic Waves",
  "Ray Optics and Optical Instrument",
  "Wave Optics",
  "Dual Nature of Radiation and Matter",
  "Atoms",
  "Nuclei",
  "Semiconductor Electronics",
  "Communication Systems"
];

List<String> chapterImages = [
  'lib/assets/vector/ch1.png',
  'lib/assets/vector/ch2.png',
  'lib/assets/vector/ch3.png',
  'lib/assets/vector/ch4.png',
  'lib/assets/vector/ch5.png',
  'lib/assets/vector/ch6.png',
  'lib/assets/vector/ch7.png',
  'lib/assets/vector/ch8.png',
  'lib/assets/vector/ch9.png',
  'lib/assets/vector/ch10.png',
  'lib/assets/vector/ch11.png',
  'lib/assets/vector/ch12.png',
  'lib/assets/vector/ch13.png',
  'lib/assets/vector/ch14.png',
  'lib/assets/vector/ch15.png',
];

class SelectChapterPage extends StatefulWidget {
  const SelectChapterPage({super.key});

  @override
  _SelectChapterPageState createState() => _SelectChapterPageState();
}

class _SelectChapterPageState extends State<SelectChapterPage> {


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
          "Select Chapter",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column( // Wrap the Container with a Column
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
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                            const SelectSubChapterPage(),
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
                                chapterImages[index],
                                width: 100, // Adjust the size as needed
                                height: 100,
                                fit: index ==12 || index == 13 || index == 14 ? BoxFit.fill : BoxFit.contain,
                              ),
                              Text(
                                chapters[index],
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
