import 'package:flutter/material.dart';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


class ARScreen1 extends StatefulWidget {
  const ARScreen1({super.key});

  @override
  State<ARScreen1> createState() => _ARScreen1State();
}

class _ARScreen1State extends State<ARScreen1> {

  late ArCoreController arCoreController;

  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
  }

  void whenArCoreViewCreated(ArCoreController arCore){
    arCoreController = arCore;
    arCoreController.onPlaneTap = controlOnPlaneTap;
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> hitsResults){
    final hit  = hitsResults.first;
    //adding the characters
    addCharcter(hit);
  }

  Future addCharcter(ArCoreHitTestResult hit) async{
    final bytes = (await rootBundle.load("lib/assets/com.png")).buffer.asUint8List();

    final characterPos = ArCoreNode(
      image: ArCoreImage(bytes:  bytes, width: 544, height: 340),
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );

    arCoreController.addArCoreNodeWithAnchor(characterPos);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
          "Conservation of Momentum",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }
}

