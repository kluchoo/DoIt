import 'package:camera/camera.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  Future<void> _setupCameraController() async {
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      setState(() {
        cameras = _cameras;
        cameraController =
            CameraController(_cameras.last, ResolutionPreset.veryHigh);
      });
      cameraController?.initialize().then((_) {
        setState(() {});
      });
    }
  }

  Widget cameraUI() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
        child: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: CameraPreview(cameraController!)),
          Center(
            child: TextButton(
              onPressed: () async {
                XFile picture = await cameraController!.takePicture();
                print(picture.path);
                Navigator.pop(context, picture);
              },
              child: const Icon(Icons.camera, size: 50, color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const StylizowanyTytul('Kamera'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: cameraUI());
  }
}
