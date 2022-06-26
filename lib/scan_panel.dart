import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanPage extends StatelessWidget {
  QRScanPage(this.onScanned, {Key? key}) : super(key: key);
  final void Function(String code) onScanned;

  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  onScanned('Failed to scan Barcode');
                } else {
                  final String code = barcode.rawValue!;
                  onScanned(code);
                }
              }),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: buildToolsOverlay(),
          ),
        ],
      ),
    );
  }

  Widget buildToolsOverlay() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color.fromRGBO(10, 10, 10, 0.5),
      ),
      child: Row(
        children: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
    );
  }
}
