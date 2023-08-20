import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optional/optional_internal.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArEarthMapScreen extends StatefulWidget {
  const ArEarthMapScreen({super.key});

  @override
  State<ArEarthMapScreen> createState() => _ArEarthMapScreenState();
}

class _ArEarthMapScreenState extends State<ArEarthMapScreen> {
  ArCoreController? augmentedRealityCoreController;
  bool isRotating = false;
  double startingRotation = 0;
  double currentRotation = 0;
  List<ArCoreNode> arCoreNodes = [];

  augmentedRealityViewCreated(ArCoreController coreController) {
    augmentedRealityCoreController = coreController;
    displayRedBall(augmentedRealityCoreController!);
  }

  displayRedBall(ArCoreController coreController) async {
    final materials = ArCoreMaterial(
      color: Colors.red,
    );

    final sphere = ArCoreSphere(
      materials: [materials],
      radius: 0.1,
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );

    augmentedRealityCoreController!.addArCoreNode(node);
    arCoreNodes.add(node);
  }

  void updateRotation(double rotation) {
    if (arCoreNodes.isNotEmpty) {
      final node = arCoreNodes.last;
      final quaternionRotation =
      vector64.Quaternion.axisAngle(vector64.Vector3(0, 1, 0), rotation);
      final updatedRotation = vector64.Quaternion(
        quaternionRotation.x,
        quaternionRotation.y,
        quaternionRotation.z,
        quaternionRotation.w,
      );
      node.rotation?.value = updatedRotation as vector64.Vector4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR Red Ball"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx != 0 || details.delta.dy != 0) {
            double dx = details.delta.dx;
            double dy = details.delta.dy;
            double touchSensitivity = 2.0;

            if (isRotating) {
              currentRotation = startingRotation + dx * touchSensitivity;
              updateRotation(currentRotation);
            }
          }
        },
        onPanStart: (details) {
          isRotating = true;
          startingRotation = currentRotation;
        },
        onPanEnd: (details) {
          isRotating = false;
        },
        child: ArCoreView(
          onArCoreViewCreated: augmentedRealityViewCreated,
        ),
      ),
    );
  }

  @override
  void dispose() {
    augmentedRealityCoreController?.dispose();
    super.dispose();
  }
}
