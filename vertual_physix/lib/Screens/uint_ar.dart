import 'dart:math';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


class ARScreen3 extends StatefulWidget {
  const ARScreen3({super.key});

  @override
  State<ARScreen3> createState() => _ARScreen3State();
}

class _ARScreen3State extends State<ARScreen3> {

  late ArCoreController arCoreController;
  late ArCoreNode sphereNode;

  double metallic = 0.0;
  double roughness = 0.4;
  double reflectance = 0.5;
  Color color = Colors.yellow;

  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    _addSpeher(arCoreController);
  }

  void _addSpeher(ArCoreController controller){
    final material = ArCoreMaterial(
      color: Colors.yellow,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius:0.5,
    );
    sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(sphereNode);
  }

  onColorChange(Color newColor){
    if(newColor != this.color){
      this.color = newColor;
      updateMaterials();
    }
  }

  onMetallicChange(double newMetallic){
    if(newMetallic != this.metallic){
      metallic = newMetallic;
      updateMaterials();
    }
  }

  onRoughnessChange(double newRoughness){
    if(newRoughness != this.roughness){
      this.roughness = newRoughness;
      updateMaterials();
    }
  }

  onReflectanceChange(double newReflectance) {
    if(newReflectance != this.reflectance){
      this.reflectance = newReflectance;
      updateMaterials();
    }
  }

  updateMaterials(){
    debugPrint("updateMaterials");
    if(sphereNode == null){
      return;
    }
    debugPrint("updateMaterials sphere node not null");
    final material = ArCoreMaterial(
      color: color,
      metallic: metallic,
      roughness: roughness,
      reflectance: reflectance,
    );
    sphereNode.shape?.materials.value = [material];
  }

  @override
  void dispose(){
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Customize 3D Object",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SphereControl(
            initialColor: color,
            initialMetallicValue: metallic,
            initialRoughnessValue: roughness,
            initialReflectanceValue: reflectance,
            onColorChange: onColorChange,
            onMetallicChange: onMetallicChange,
            onRoughnessChange: onRoughnessChange,
            onReflectanceChange: onRoughnessChange,
          ),
          Expanded(
              child: ArCoreView(
                onArCoreViewCreated: whenArCoreViewCreated,
              )
          ),
        ],
      ),
    );
  }
}

class SphereControl extends StatefulWidget {
  final double initialRoughnessValue;
  final double initialReflectanceValue;
  final double initialMetallicValue;
  final Color initialColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<double> onMetallicChange;
  final ValueChanged<double> onRoughnessChange;
  final ValueChanged<double> onReflectanceChange;

  const SphereControl({
    required this.initialRoughnessValue,
    required this.initialReflectanceValue,
    required this.initialMetallicValue,
    required this.initialColor,
    required this.onColorChange,
    required this.onMetallicChange,
    required this.onRoughnessChange,
    required this.onReflectanceChange
  });

  @override
  State<SphereControl> createState() => _SphereControlState();
}

class _SphereControlState extends State<SphereControl> {

  late double metallicValue=0;
  late double roughnessValue;
  late double reflectanceValue;
  late Color color;

  @override
  void initState() {
    roughnessValue = widget.initialRoughnessValue;
    reflectanceValue = widget.initialReflectanceValue;
    roughnessValue = widget.initialRoughnessValue;
    color = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(41, 32, 70, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purpleAccent, // Set the button's background color
                  ),
                  child: const Text("Random Color"),
                  onPressed: () {
                    final newColor = Colors.accents[Random().nextInt(14)];
                    widget.onColorChange(newColor);
                    setState(() {
                      color = newColor;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: color,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                const Text(
                  "Metallic",
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  ),
                ),
                Checkbox(
                  activeColor: Colors.purpleAccent,
                  checkColor: Colors.white,
                  value: metallicValue == 1.0,
                  onChanged: (value){
                    metallicValue = value! ? 1.0 : 0.0;
                    widget.onMetallicChange(metallicValue);
                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                const Text("Roughness",style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),),
                Expanded(
                  child: Slider(
                    value: roughnessValue,
                    divisions: 10,
                    activeColor: Colors.purpleAccent,
                    thumbColor: Colors.purpleAccent,
                    onChangeEnd: (value) {
                      roughnessValue = value;
                      widget.onRoughnessChange(roughnessValue);
                    },
                    onChanged: (double value){
                      setState(() {
                        roughnessValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text("Reflectance", style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),),
                Expanded(
                  child: Slider(
                    value: reflectanceValue,
                    divisions: 10,
                    activeColor: Colors.purpleAccent,
                    thumbColor: Colors.purpleAccent,
                    onChangeEnd: (value) {
                      reflectanceValue = value;
                      widget.onReflectanceChange(reflectanceValue);
                    },
                    onChanged: (double value){
                      setState(() {
                        reflectanceValue = value;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
