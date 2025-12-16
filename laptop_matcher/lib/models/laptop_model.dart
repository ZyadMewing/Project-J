class Laptop {
  final String id;
  final String name;
  final String brand;
  final double price;      // Cost
  final int ram;           // Benefit
  final int storage;       // Benefit
  final int processorScore;// Benefit
  final double weight;     // Cost
  final int batteryLife;   // Benefit
  
  // Detail Tambahan (Untuk Halaman Detail)
  final String processorName; // e.g., Intel Core i5-8250U
  final String gpu;           // e.g., NVIDIA MX150 2GB
  final String screenSize;    // e.g., 14.0 Inch FHD IPS
  
  final String linkUrl;
  final String imageAsset; // Ganti dari URL ke Asset Lokal

  Laptop({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.ram,
    required this.storage,
    required this.processorScore,
    required this.weight,
    required this.batteryLife,
    required this.processorName,
    required this.gpu,
    required this.screenSize,
    required this.linkUrl,
    required this.imageAsset,
  });
}