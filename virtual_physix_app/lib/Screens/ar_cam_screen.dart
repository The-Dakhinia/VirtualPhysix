import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

class ArCamScreen extends StatefulWidget {
  const ArCamScreen({Key? key}) : super(key: key);

  @override
  _ArCamScreenState createState() => _ArCamScreenState();
}

class _ArCamScreenState extends State<ArCamScreen> {
  late ArCoreController arCoreController;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Physics App'),
      ),
      body: Center(
        child: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    // Set up plane detection callback
    arCoreController.onPlaneDetected = _handlePlaneDetected as ArCorePlaneHandler?;
  }

  void _handlePlaneDetected(List<ArCorePlane> detectedPlanes) {
    // Handle detected planes (e.g., place 3D objects)
    // The detectedPlanes list contains information about detected planes.
  }
}
