import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Jangan lupa import ini
import '../models/laptop_model.dart';
import '../utils/launcher_helper.dart';

class ComparisonPage extends StatelessWidget {
  final Laptop laptop1;
  final Laptop laptop2;

  const ComparisonPage({
    super.key,
    required this.laptop1,
    required this.laptop2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Background Navy
      appBar: AppBar(
        title: const Text("VS BATTLE MODE ⚔️"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // HEADER FOTO VS FOTO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(laptop1),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                  child: Text(
                    "VS",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.amber,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                _buildHeader(laptop2),
              ],
            ),
            const SizedBox(height: 20),

            // TABEL PERBANDINGAN
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildRow(
                    "Harga",
                    "Rp ${NumberFormat('#,###', 'id_ID').format(laptop1.price)}",
                    "Rp ${NumberFormat('#,###', 'id_ID').format(laptop2.price)}",
                    laptop1.price < laptop2.price, // Murah = Menang
                  ),
                  _buildRow(
                    "RAM",
                    "${laptop1.ram} GB",
                    "${laptop2.ram} GB",
                    laptop1.ram > laptop2.ram,
                  ),
                  _buildRow(
                    "Storage",
                    "${laptop1.storage} GB",
                    "${laptop2.storage} GB",
                    laptop1.storage > laptop2.storage,
                  ),
                  _buildRow(
                    "Benchmark",
                    "${laptop1.processorScore}",
                    "${laptop2.processorScore}",
                    laptop1.processorScore > laptop2.processorScore,
                  ),
                  _buildRow(
                    "Baterai",
                    "${laptop1.batteryLife} Jam",
                    "${laptop2.batteryLife} Jam",
                    laptop1.batteryLife > laptop2.batteryLife,
                  ),
                  _buildRow(
                    "Berat",
                    "${laptop1.weight} Kg",
                    "${laptop2.weight} Kg",
                    laptop1.weight < laptop2.weight,
                  ), // Ringan = Menang
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TOMBOL CEK TOKO
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () => LauncherHelper.openUrl(laptop1.linkUrl),
                    child: const Text(
                      "Cek Kiri",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => LauncherHelper.openUrl(laptop2.linkUrl),
                    child: const Text(
                      "Cek Kanan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Laptop laptop) {
    return Expanded(
      child: Column(
        children: [
          // Gambar Bulat
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: DecorationImage(
                image: AssetImage(laptop.imageAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            laptop.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String val1, String val2, bool isLeftBetter) {
    bool isEqual = val1 == val2;
    // Hijau Tua utk Menang, Merah Bata utk Kalah
    Color color1 = isEqual
        ? Colors.black87
        : (isLeftBetter ? Colors.green[700]! : Colors.red[300]!);
    Color color2 = isEqual
        ? Colors.black87
        : (!isLeftBetter ? Colors.green[700]! : Colors.red[300]!);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              val1,
              textAlign: TextAlign.left,
              style: TextStyle(color: color1, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              val2,
              textAlign: TextAlign.right,
              style: TextStyle(color: color2, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
