import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:m2online_recharge_app/screens/Scanner/widgets/scan_app_bar.dart';
import 'package:m2online_recharge_app/screens/Scanner/widgets/scan_bottom_card.dart';
import 'package:m2online_recharge_app/screens/Scanner/widgets/scanning_box.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras!.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraReady = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Actual camera view
          Positioned.fill(
            child:
                _isCameraReady && _controller != null
                    ? CameraPreview(_controller!)
                    : const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
          ),
          // Top App Bar
          const ScanAppBar(),

          // Blur Overlay and Scanning Box
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(child: const ScanningBox()),
            ),
          ),

          // Bottom Card Section
          const Align(
            alignment: Alignment.bottomCenter,
            child: ScanBottomCard(),
          ),
        ],
      ),
    );
  }
}
