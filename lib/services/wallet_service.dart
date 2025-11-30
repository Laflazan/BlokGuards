import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  static Future<Map<String, dynamic>?> createTempWallet({
    required double amount,
    required int durationMinutes,
  }) async {
    final url = Uri.parse('$baseUrl/api/temp-wallet');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'amount': amount,
        'durationMinutes': durationMinutes,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Backend error: ${response.statusCode} → ${response.body}');
      return null;
    }
  }
}
