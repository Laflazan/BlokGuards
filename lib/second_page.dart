import 'package:flutter/material.dart';
import 'third_page.dart';
import 'add_wallet_page.dart';
import 'qr_preview_page.dart'; // ✅ QR önizleme sayfası import

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF50A3F7);
    const bgDark = Color(0xFF101922);
    const accentDark = Color(0xFF0A1931);

    return Scaffold(
      backgroundColor: bgDark,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 80, right: 4),
        child: FloatingActionButton(
          backgroundColor: primary,
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: bgDark.withOpacity(0.8),
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Icons.dashboard, "Dashboard", isActive: true),
            navItem(Icons.receipt_long, "Transactions"),
            navItem(Icons.qr_code_scanner, "Scan QR"),
            navItem(Icons.person, "Profile"),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Top App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  const Text(
                    "BLOCKGUARDS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings, color: Colors.white),
                  )
                ],
              ),
            ),

            // Total Balance Label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Total Balance",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ),

            // Total Balance Value
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                "\$1,250.75",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Cash In Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // ✅ AddWalletPage'e animasyonlu geçiş
                    Navigator.of(context).push(_createAddWalletRoute());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Cash In with MoneyGram",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Active Wallets Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Active Wallets",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Wallet Cards (ANİMASYONLU GEÇİŞLİ)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createThirdPageRoute());
                    },
                    child: walletCard(
                      context,
                      "Coffee Fund",
                      "\$25.00",
                      "Expires in 1d 4h",
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createThirdPageRoute());
                    },
                    child: walletCard(
                      context,
                      "Weekend Trip",
                      "\$350.50",
                      "Expires in 2d 11h",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // --- ANİMASYONLU ROUTE: ThirdPage (harcama detayları vs) ---
  static Route _createThirdPageRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
      const ThirdPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const beginOffset = Offset(0.0, 0.1); // hafif alttan gelsin
        const endOffset = Offset.zero;
        const curve = Curves.easeOutCubic;

        final offsetTween =
        Tween(begin: beginOffset, end: endOffset).chain(CurveTween(curve: curve));
        final opacityTween =
        Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(offsetTween),
          child: FadeTransition(
            opacity: animation.drive(opacityTween),
            child: child,
          ),
        );
      },
    );
  }

  // --- ANİMASYONLU ROUTE: AddWalletPage (Cash In akışı) ---
  static Route _createAddWalletRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
      const AddWalletPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const beginOffset = Offset(0.0, 0.1);
        const endOffset = Offset.zero;
        const curve = Curves.easeOutCubic;

        final offsetTween =
        Tween(begin: beginOffset, end: endOffset).chain(CurveTween(curve: curve));
        final opacityTween =
        Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(offsetTween),
          child: FadeTransition(
            opacity: animation.drive(opacityTween),
            child: child,
          ),
        );
      },
    );
  }

  // Wallet Card Widget
  static Widget walletCard(
      BuildContext context,
      String title,
      String amount,
      String expires,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1931).withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title + qr button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Basit bir QR payload (ileride gerçek cüzdan ID / backend verisi koyarız)
                  final qrData =
                      'WALLET|TITLE=$title|AMOUNT=$amount|EXPIRES=$expires';

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrPreviewPage(qrData: qrData),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.qr_code_2,
                  color: Color(0xFF50A3F7),
                ),
              ),
            ],
          ),

          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(Icons.timer, size: 18, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                expires,
                style: const TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bottom Nav Item
  static Widget navItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF50A3F7) : Colors.white54,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF50A3F7) : Colors.white54,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        )
      ],
    );
  }
}
