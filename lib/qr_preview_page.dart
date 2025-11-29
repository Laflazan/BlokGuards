import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPreviewPage extends StatelessWidget {
  final String qrData;

  const QrPreviewPage({
    Key? key,
    required this.qrData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color kPrimary = Color(0xFF4FA3F7);
    const Color kBackgroundDark = Color(0xFF0A1931);

    return Scaffold(
      backgroundColor: kBackgroundDark,
      appBar: AppBar(
        backgroundColor: kBackgroundDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          " Wallet QR",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 260,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 24),
            const Text(
              "Scan to pay from temporary wallet",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              qrData,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white30,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
