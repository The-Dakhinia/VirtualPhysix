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
        title: const Text(
          "Select Sub Chapter ",
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
              colors: [Colors.deepPurple, Colors.black]
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

                  },
                  child: Card(
                    color: Colors.deepPurple[400],
                    elevation: 5,
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