import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/laptop_data.dart';
import '../models/laptop_model.dart';
import '../services/spk_service.dart';
import '../utils/spk_helper.dart';
import 'comparison_page.dart';
import 'detail_page.dart';

class ResultPage extends StatefulWidget {
  final double budget;
  final String category;

  const ResultPage({super.key, required this.budget, required this.category});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final SpkService _spkService = SpkService();
  List<Map<String, dynamic>> _rekomendasi = [];
  final List<Laptop> _selectedForCompare = []; // Penampung laptop yg dicentang

  @override
  void initState() {
    super.initState();
    _hitungRekomendasi();
  }

  void _hitungRekomendasi() {
    // Filter Budget
    List<Laptop> filteredLaptops = laptopList.where((laptop) {
      return laptop.price <= widget.budget;
    }).toList();

    if (filteredLaptops.isEmpty) {
      setState(() => _rekomendasi = []);
      return;
    }

    // Hitung SAW
    Map<String, double> bobot = SpkHelper.getWeightsByCategory(widget.category);
    var hasil = _spkService.hitungSAW(filteredLaptops, bobot);

    setState(() {
      _rekomendasi = hasil;
    });
  }

  void _onLaptopSelected(bool? selected, Laptop laptop) {
    setState(() {
      if (selected == true) {
        if (_selectedForCompare.length < 2) {
          _selectedForCompare.add(laptop);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Maksimal bandingkan 2 laptop ya!",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        _selectedForCompare.remove(laptop);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- PERBAIKAN: TOMBOL MUNCUL DI SINI ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _selectedForCompare.length == 2
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFFE94560),
              icon: const Icon(Icons.compare_arrows, color: Colors.white),
              label: const Text(
                "BANDINGKAN SEKARANG VS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComparisonPage(
                      laptop1: _selectedForCompare[0],
                      laptop2: _selectedForCompare[1],
                    ),
                  ),
                );
              },
            )
          : null, // Kalau belum pilih 2, tombol hilang

      // ----------------------------------------
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const BackButton(color: Colors.white),
                    Expanded(
                      child: Text(
                        "Hasil: ${widget.category}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // INFO BOX
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Centang 2 kotak di kanan untuk membandingkan Head-to-Head.",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              // LIST
              Expanded(
                child: _rekomendasi.isEmpty
                    ? const Center(
                        child: Text(
                          "Tidak ada laptop yang cocok :(",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 80,
                        ), // Padding bawah biar gak ketutup tombol
                        itemCount: _rekomendasi.length,
                        itemBuilder: (context, index) {
                          final Laptop laptop = _rekomendasi[index]['laptop'];
                          final double score = _rekomendasi[index]['score'];
                          final bool isSelected = _selectedForCompare.contains(
                            laptop,
                          );

                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailPage(laptop: laptop),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    // Gambar
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        laptop.imageAsset,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.laptop),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            laptop.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Rp ${NumberFormat('#,###', 'id_ID').format(laptop.price)}",
                                            style: const TextStyle(
                                              color: Color(0xFFE94560),
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            "SAW: ${score.toStringAsFixed(3)}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Checkbox
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 14,
                                          backgroundColor: index == 0
                                              ? Colors.green
                                              : Colors.grey[400],
                                          child: Text(
                                            "${index + 1}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                          value: isSelected,
                                          activeColor: const Color(0xFFE94560),
                                          onChanged: (val) =>
                                              _onLaptopSelected(val, laptop),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
