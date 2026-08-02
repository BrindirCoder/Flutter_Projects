import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/coupon_model.dart';

class CouponHomeScreen extends StatefulWidget {
  const CouponHomeScreen({super.key});

  @override
  State<CouponHomeScreen> createState() => _CouponHomeScreenState();
}

class _CouponHomeScreenState extends State<CouponHomeScreen> {
  final List<CouponModel> _coupons = [
    CouponModel(
      id: '1',
      storeName: 'Amazon',
      discount: '30% OFF',
      code: 'AMZ30OFF',
      category: 'ئەلیکترۆنیات',
      color: const Color(0xFFF59E0B),
    ),
    CouponModel(
      id: '2',
      storeName: 'Nike',
      discount: '50% OFF',
      code: 'NIKE50',
      category: 'پۆشاک',
      color: const Color(0xFFEF4444),
    ),
    CouponModel(
      id: '3',
      storeName: 'Udemy',
      discount: '80% OFF',
      code: 'LEARN2026',
      category: 'کورسەکان',
      color: const Color(0xFF10B981),
    ),
    CouponModel(
      id: '4',
      storeName: 'AliExpress',
      discount: '20% OFF',
      code: 'ALI20',
      category: 'کەلوپەل',
      color: const Color(0xFF8B5CF6),
    ),
  ];

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('کۆدی ($code) کۆپی کرا!'),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('کوپۆن و داشکاندنەکان 🏷️', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _coupons.length,
        itemBuilder: (context, index) {
          final coupon = _coupons[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                // Discount Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: coupon.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: coupon.color.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        coupon.discount,
                        style: TextStyle(color: coupon.color, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coupon.category,
                        style: const TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Details & Copy Button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.storeName,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24, style: BorderStyle.solid),
                        ),
                        child: Text(
                          'کۆد: ${coupon.code}',
                          style: const TextStyle(color: Colors.white70, fontFamily: 'monospace', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.copy_rounded, color: Color(0xFF6366F1), size: 28),
                  onPressed: () => _copyCode(coupon.code),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}