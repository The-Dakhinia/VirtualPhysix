import 'package:flutter/material.dart';
import 'sub_chapter_page.dart';

List<String> chapters = [
  "Electric Charges and Fields",
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
        title: const Text(
          "Select Chapter",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
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
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: chapters.length, // Change itemCount to 10
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectSubChapterPage(),
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
                    child: ListTile(
                      title: Text(
                        chapters[index], // Example content
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
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
