import 'package:flutter/material.dart';

/// MODEL: Spending Category (private class, sadece bu dosyada kullanılıyor)
class _SpendingCategory {
  final IconData icon;
  final String label;

  const _SpendingCategory({
    required this.icon,
    required this.label,
  });
}

class AddWalletPage extends StatefulWidget {
  const AddWalletPage({Key? key}) : super(key: key);

  @override
  State<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  // --- COLORS ---
  static const Color kPrimary = Color(0xFF4FA3F7);
  static const Color kBackgroundDark = Color(0xFF0A1931);
  static const Color kCardDark = Color(0xFF101922);
  static const Color kTextSecondary = Color(0xFF9CABBA);

  // Amount ve süre
  double _amount = 100;
  double _durationHours = 4;
  int _selectedCategoryIndex = 0;
  bool _geoLockEnabled = false;

  // Spending categories
  static const List<_SpendingCategory> _categories = [
    _SpendingCategory(
      icon: Icons.shopping_cart,
      label: 'Groceries',
    ),
    _SpendingCategory(
      icon: Icons.directions_bus,
      label: 'Transport',
    ),
    _SpendingCategory(
      icon: Icons.restaurant,
      label: 'Dining',
    ),
    _SpendingCategory(
      icon: Icons.confirmation_number,
      label: 'Entertainment',
    ),
    _SpendingCategory(
      icon: Icons.apps,
      label: 'All',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundDark,
      appBar: AppBar(
        backgroundColor: kBackgroundDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Create Temporary Wallet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MoneyGram info badge
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kCardDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: kPrimary, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Load cash via MoneyGram, then lock a limit and time for this temporary wallet.",
                        style: TextStyle(
                          color: kTextSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Amount label
              const Text(
                "Max Spending Amount",
                style: TextStyle(
                  color: Colors.white,
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
                      color: kTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              Slider(
                value: _amount,
                min: 10,
                max: 1000,
                divisions: 99,
                activeColor: kPrimary,
                inactiveColor: Colors.white24,
                onChanged: (val) {
                  setState(() {
                    _amount = val;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Duration
              const Text(
                "Wallet Duration (Hours)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_durationHours.toStringAsFixed(0)}h",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "After this time, wallet auto-locks.",
                    style: TextStyle(
                      color: kTextSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              Slider(
                value: _durationHours,
                min: 1,
                max: 72,
                divisions: 71,
                activeColor: kPrimary,
                inactiveColor: Colors.white24,
                onChanged: (val) {
                  setState(() {
                    _durationHours = val;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Categories title
              const Text(
                "Spending Category",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = index == _selectedCategoryIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? kPrimary : kCardDark,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? kPrimary
                                : Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              category.icon,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              category.label,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Geo-lock switch
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: kCardDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: kPrimary, size: 20),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Geo-Lock (Merchant Location)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Switch(
                      value: _geoLockEnabled,
                      activeColor: kPrimary,
                      inactiveThumbColor: Colors.white54,
                      onChanged: (val) {
                        setState(() {
                          _geoLockEnabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Generate QR / Create Wallet Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Şimdilik sadece pop + snackBar, sonra backend / Stellar bağlarız
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: kCardDark,
                        content: Text(
                          "Temporary wallet created: \$${_amount.toStringAsFixed(0)}, ${_durationHours.toStringAsFixed(0)}h, ${_categories[_selectedCategoryIndex].label}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Generate Wallet & QR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
