import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // باگراوندی تێکەڵاو (Gradient) بە ڕەنگی شەو و ئاسمان
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF311B92)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // ناوی شار
                const Text(
                  'هەولێر',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'سێشەممە، ٢١ی تەممووز',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 30),

                // پلەی گەرمی و ئایکۆنی سەرەکی
                const Icon(
                  Icons.wb_sunny_rounded,
                  size: 100,
                  color: Colors.amberAccent,
                ),
                const SizedBox(height: 10),
                const Text(
                  '38°C',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'ئاسمان ساماڵە',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 40),

                // کاڕتی شووشەیی بۆ زانیارییە زیادەکان
                GlassCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeatherDetail(
                        Icons.water_drop_outlined,
                        'شێی هەوا',
                        '22%',
                      ),
                      _buildWeatherDetail(
                        Icons.air_rounded,
                        'خێرایی با',
                        '14 km/h',
                      ),
                      Icons.thermostat_outlined == Icons.thermostat_outlined
                          ? _buildWeatherDetail(
                              Icons.thermostat_outlined,
                              'پەستان',
                              '1012 hPa',
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // مێتۆدێکی یارمەتیدەر بۆ دروستکردنی ستوونی زانیارییەکان
  Widget _buildWeatherDetail(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
