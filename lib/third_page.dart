// third_page.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'qr_preview_page.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  // --- COLORS (BLOCKGUARDS DARK THEME) ---
  static const Color kPrimary = Color(0xFF4FA3F7);
  static const Color kBackgroundDark = Color(0xFF0A1931);
  static const Color kCardDark = Color(0xFF101922);
  static const Color kTextPrimary = Colors.white;
  static const Color kTextSecondary = Color(0xFF9CABBA);

  double _amount = 50.0;
  final double _maxAmount = 250.0;
  bool _isHours = true;
  int _durationValue = 24;

  bool _geoLockEnabled = false;

  // ---- RANDOM STRING + QR PAYLOAD ÜRETİCİLERİ ----

  String _randomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();
    return List.generate(
      length,
          (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  String _buildQrPayload() {
    final unit = _isHours ? 'H' : 'D';
    final geo = _geoLockEnabled ? 'ON' : 'OFF';
    final now = DateTime.now().toIso8601String();
    final nonce = _randomString(8);

    return 'WG_TEMP_WALLET|'
        'AMT=${_amount.toStringAsFixed(2)}|'
        'DUR=$_durationValue$unit|'
        'GEO=$geo|'
        'TS=$now|'
        'NONCE=$nonce';
  }

  @override
  Widget build(BuildContext context) {
    // SABİT DARK TEMA
    const backgroundColor = kBackgroundDark;
    const cardColor = kCardDark;
    const textPrimary = kTextPrimary;
    const textSecondary = kTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // --- TOP BAR ---
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: backgroundColor,
                  child: Row(
                    children: const [
                      BackButton(color: textPrimary),
                      Expanded(
                        child: Text(
                          'Create Temporary Wallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                ),

                // --- MAIN CONTENT ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),

                        // --- AVAILABLE TO SEND ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Available to send',
                                      style: TextStyle(
                                        color: textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$1,250.50',
                                      style: TextStyle(
                                        color: textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.account_balance_wallet,
                                size: 36,
                                color: kPrimary,
                              ),
                            ],
                          ),
                        ),

                        // --- AMOUNT (AddWallet tarzı) ---
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Max Spending Amount",
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${_amount.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Limit",
                                    style: TextStyle(
                                      color: textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Slider(
                                value: _amount,
                                min: 0,
                                max: _maxAmount,
                                divisions: _maxAmount.toInt(),
                                activeColor: kPrimary,
                                inactiveColor: Colors.white24,
                                onChanged: (val) {
                                  setState(() {
                                    _amount = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // --- EXPIRES CARD ---
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expires In',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildToggle("Hours", _isHours, () {
                                      setState(() => _isHours = true);
                                    }),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildToggle("Days", !_isHours, () {
                                      setState(() => _isHours = false);
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Duration counter
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xFF0F1B2E),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (_durationValue > 1) {
                                          setState(() => _durationValue--);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: textPrimary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          _durationValue.toString(),
                                          style: const TextStyle(
                                            color: textPrimary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          setState(() => _durationValue++),
                                      icon: const Icon(
                                        Icons.add,
                                        color: textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        // --- SECURITY / GEO LOCK ---
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Geo-Lock',
                                          style: TextStyle(
                                            color: textPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Restrict payments to a specific area.',
                                          style: TextStyle(
                                            color: textSecondary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: _geoLockEnabled,
                                    activeColor: Colors.white,
                                    activeTrackColor: kPrimary,
                                    onChanged: (v) =>
                                        setState(() => _geoLockEnabled = v),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                        const Color(0xFF182235),
                                        child: const Icon(
                                          Icons.add_location_alt,
                                          color: kPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Set Location',
                                            style: TextStyle(
                                              color: kPrimary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Tap to select an area on the map',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: textSecondary,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // --- CTA BUTTON ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0A1931),
                      Color(0x000A1931),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final qrData = _buildQrPayload();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QrPreviewPage(qrData: qrData),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 10,
                        shadowColor: kPrimary.withOpacity(0.6),
                      ),
                      child: const Text(
                        "Create QR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String text, bool selected, VoidCallback onTap) {
    final Color bg = selected ? kPrimary : const Color(0xFF182235);
    final Color txt = selected ? Colors.white : kTextSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? kPrimary : Colors.white24,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: txt,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
