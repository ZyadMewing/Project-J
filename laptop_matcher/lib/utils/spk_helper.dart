class SpkHelper {
  static Map<String, double> getWeightsByCategory(String category) {
    switch (category) {
      case 'Gaming / Berat':
        // Gaming: Berat & Baterai bobotnya kecil saja
        return {
          'price': 0.10, 
          'ram': 0.25, 
          'storage': 0.15, 
          'cpu': 0.40,
          'weight': 0.05, // Gak ngaruh
          'battery': 0.05 // Gak ngaruh
        };
      
      case 'Coding / Dev':
        // Coding: Mobilitas (Weight & Battery) itu penting!
        return {
          'price': 0.15,
          'ram': 0.25, 
          'storage': 0.10, 
          'cpu': 0.20,
          'weight': 0.15, // Penting
          'battery': 0.15 // Penting
        };
        
      case 'Office / Kuliah':
        // Mahasiswa umum: Yang penting murah, ringan, awet.
        return {
          'price': 0.30,
          'ram': 0.10, 
          'storage': 0.10, 
          'cpu': 0.10,
          'weight': 0.20, // Sangat penting
          'battery': 0.20 // Sangat penting
        };

      default:
        // Desain Grafis dsb...
        return {
          'price': 0.20, 'ram': 0.20, 'storage': 0.20, 'cpu': 0.20, 
          'weight': 0.10, 'battery': 0.10
        };
    }
  }
}