import '../models/laptop_model.dart';
import 'dart:math';

class SpkService {
  List<Map<String, dynamic>> hitungSAW(List<Laptop> laptops, Map<String, double> bobot) {
    
    // 1. CARI NILAI MAX/MIN
    double minPrice = laptops.map((e) => e.price).reduce(min);
    double maxRam = laptops.map((e) => e.ram.toDouble()).reduce(max);
    double maxStorage = laptops.map((e) => e.storage.toDouble()).reduce(max);
    double maxCpu = laptops.map((e) => e.processorScore.toDouble()).reduce(max);
    
    // BARU:
    double minWeight = laptops.map((e) => e.weight).reduce(min); // Cost (Cari terendah)
    double maxBattery = laptops.map((e) => e.batteryLife.toDouble()).reduce(max); // Benefit

    List<Map<String, dynamic>> hasilRanking = [];

    for (var laptop in laptops) {
      // 2. NORMALISASI
      double normPrice = minPrice / laptop.price; // Cost
      double normRam = laptop.ram / maxRam;       // Benefit
      double normStorage = laptop.storage / maxStorage; // Benefit
      double normCpu = laptop.processorScore / maxCpu;  // Benefit
      
      // BARU:
      double normWeight = minWeight / laptop.weight; // Cost (Min / Nilai)
      double normBattery = laptop.batteryLife / maxBattery; // Benefit (Nilai / Max)

      // 3. HITUNG SKOR AKHIR (Total Bobot Harus 1.0)
      // Kita pakai operator ?? 0.0 jaga-jaga kalau bobotnya null
      double skorAkhir = 
          (normPrice * (bobot['price'] ?? 0)) +
          (normRam * (bobot['ram'] ?? 0)) +
          (normStorage * (bobot['storage'] ?? 0)) +
          (normCpu * (bobot['cpu'] ?? 0)) +
          (normWeight * (bobot['weight'] ?? 0)) +   // Tambahan
          (normBattery * (bobot['battery'] ?? 0));  // Tambahan

      hasilRanking.add({
        'laptop': laptop,
        'score': skorAkhir,
      });
    }

    hasilRanking.sort((a, b) => b['score'].compareTo(a['score']));
    return hasilRanking;
  }
}