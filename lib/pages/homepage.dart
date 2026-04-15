import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepages extends StatelessWidget {
  const Homepages({super.key});

  Future<void> _showExitDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Keluar Aplikasi?"),
            content: const Text(
              "Apakah Anda yakin ingin keluar dari aplikasi Tugas Kelompok?",
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Batal"),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text("Keluar"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        _showExitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              tooltip: 'Logout',
              onPressed:
                  () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.diversity_3, color: Colors.white, size: 24),
                        SizedBox(width: 10),
                        Text(
                          "Tim Pengembang",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white30,
                      height: 24,
                      thickness: 1,
                    ),
                    _buildMemberText("Gilang Restu Maulana", "123230060"),
                    _buildMemberText("Ahmad Habib Hamidi", "123230077"),
                    _buildMemberText("Raymond Agung R.", "123230129"),
                    _buildMemberText("Laksana Atmaja P.", "123230235"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Menu Kalkulasi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildMenuCard(
                    context,
                    Icons.calculate_outlined,
                    "Kalkulator",
                    '/kalkulator',
                  ),
                  _buildMenuCard(
                    context,
                    Icons.format_list_numbered,
                    "Total Angka",
                    '/jumlah-angka',
                  ),
                  _buildMenuCard(
                    context,
                    Icons.rule,
                    "Ganjil/Genap & Prisma",
                    '/ganjil-genap',
                  ),
                  _buildMenuCard(
                    context,
                    Icons.change_history,
                    "Piramida",
                    '/piramid',
                  ),
                  _buildMenuCard(
                    context,
                    Icons.timer,
                    "Stopwatch",
                    '/stopwatch',
                  ),
                  _buildMenuCard(
                    context,
                    Icons.calendar_today,
                    "Hari & Weton",
                    '/weton',
                  ),
                  _buildMenuCard(context, Icons.cake, "Hitung Umur", '/umur'),
                  _buildMenuCard(
                    context,
                    Icons.mosque,
                    "Tanggal Hijriah",
                    '/hijriah',
                  ),
                  _buildMenuCard(
                    context,
                    Icons.temple_hindu,
                    "Kalender Saka",
                    '/saka',
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberText(String name, String nim) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            nim,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    IconData icon,
    String title,
    String routeName,
  ) {
    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, routeName),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
