import 'package:flutter/material.dart';
import '../models/laptop_model.dart';
import '../utils/launcher_helper.dart';

class DetailPage extends StatelessWidget {
  final Laptop laptop;
  const DetailPage({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C3E50), Color(0xFF000000)], // Gradient Dark Blue ke Black
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(laptop.name, style: const TextStyle(fontSize: 16, shadows: [Shadow(color: Colors.black, blurRadius: 10)])),
                background: Image.asset( // Pakai Image.asset sekarang
                  laptop.imageAsset, 
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Container(color: Colors.grey, child: const Icon(Icons.laptop, size: 50)),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HARGA
                Text("Rp ${laptop.price.toStringAsFixed(0)}", 
                    style: const TextStyle(fontSize: 28, color: Color(0xFFE94560), fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                
                // DATA TABLE SPEK
                _buildSpecItem("Processor", laptop.processorName),
                _buildSpecItem("Benchmark Score", "${laptop.processorScore} Pts"),
                _buildSpecItem("RAM", "${laptop.ram} GB"),
                _buildSpecItem("Storage", "${laptop.storage} GB SSD"),
                _buildSpecItem("GPU / VGA", laptop.gpu),
                _buildSpecItem("Layar", laptop.screenSize),
                _buildSpecItem("Berat", "${laptop.weight} Kg"),
                _buildSpecItem("Baterai", "~${laptop.batteryLife} Jam"),

                const SizedBox(height: 30),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => LauncherHelper.openUrl(laptop.linkUrl),
                    child: const Text("Cek Ketersediaan di Toko", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Glassmorphism dikit
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}