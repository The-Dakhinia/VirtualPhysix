import 'dart:typed_data';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARScreen2 extends StatefulWidget {
  const ARScreen2({super.key});

  @override
  State<ARScreen2> createState() => _ARScreen2State();
}

class _ARScreen2State extends State<ARScreen2> {

  late ArCoreController arCoreController;


  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handlerOnPlaneTap;
  }

  void onTapHandler(String name){
    print("Flutter: onNodeTap");
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  void _handlerOnPlaneTap(List<ArCoreHitTestResult> hits){
    final hit = hits.first;
    _addSphere(hit);
  }

  Future _addSphere(ArCoreHitTestResult hit) async {

    final ByteData textureByteS = await rootBundle.load('lib/assets/sun.jpg');
    final ByteData textureByte = await rootBundle.load('lib/assets/earth.jpg');
    final ByteData textureByteM = await rootBundle.load('lib/assets/moon.png');

    final sunMaterial = ArCoreMaterial(
        color: const Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureByteS.buffer.asUint8List()
    );

    final earthMaterial = ArCoreMaterial(
        color: const Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureByte.buffer.asUint8List()
    );

    final moonMaterial = ArCoreMaterial(
        color: Colors.grey,
        textureBytes: textureByteM.buffer.asUint8List()
    );

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );
    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );

    final earth = ArCoreNode(
        shape: earthShape,
        children: [moon],
        position: vector.Vector3(0.8, 0.0, 0.0),
        rotation: hit.pose.rotation
    );

    final sunShape = ArCoreSphere(
      materials: [sunMaterial],
      radius: 0.3,
    );

    final sun = ArCoreNode(
        shape: sunShape,
        children: [earth],
        position: hit.pose.translation + vector.Vector3(0.0, 0.5, 0.0),
        rotation: hit.pose.rotation
    );

    arCoreController.addArCoreNodeWithAnchor(sun);

    @override
    void dispose(){
      super.dispose();
      arCoreController.dispose();
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            "Visualize Space",
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ArCoreView(
          onArCoreViewCreated: whenArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }
}

