import 'package:audioplayers/audioplayers.dart';
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
  final plyer = AudioPlayer();
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
    addObject(hit);
  }

  void addObject(ArCoreHitTestResult plane) async {
    // final ByteData data = await rootBundle.load('assets/Chicken_01/Chicken_01.gltf');
    // final Uint8List bytes = data.buffer.asUint8List();

    final objectNode = ArCoreReferenceNode(
      name: 'object_node',
      objectUrl: 'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb',
      // objectUrl: 'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/BrainStem/glTF-Binary/BrainStem.glb',
      position: plane.pose.translation,
      scale: vector.Vector3(0.01, 0.01, 0.01), // Adjust the scale as needed
    );

    arCoreController.addArCoreNode(objectNode);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
          "COM",
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

