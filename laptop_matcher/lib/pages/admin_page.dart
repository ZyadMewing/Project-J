import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/laptop_data.dart';
import '../models/laptop_model.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Fungsi Refresh UI
  void _refresh() {
    setState(() {});
  }

  // --- FUNGSI HAPUS (DELETE) ---
  void _deleteLaptop(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        title: const Text("Hapus Data?", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Yakin mau hapus? Data gak bisa balik lho.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                laptopList.removeAt(index);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Data Terhapus!")));
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- FUNGSI TAMBAH & EDIT (FORM DIALOG) ---
  void _showFormDialog({Laptop? laptopToEdit, int? index}) {
    final bool isEditMode = laptopToEdit != null;

    // Kunci Form untuk Validasi
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Controllers
    final nameCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.name : '',
    );
    final brandCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.brand : '',
    );
    final priceCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.price.toStringAsFixed(0) : '',
    );

    final ramCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.ram.toString() : '',
    );
    final storageCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.storage.toString() : '',
    );
    final scoreCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.processorScore.toString() : '',
    );

    final weightCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.weight.toString() : '',
    );
    final battCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.batteryLife.toString() : '',
    );

    final procNameCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.processorName : '',
    );
    final gpuCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.gpu : '',
    );
    final screenCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.screenSize : '',
    );
    final imageCtrl = TextEditingController(
      text: isEditMode ? laptopToEdit.imageAsset : 'assets/images/t480.png',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        title: Text(
          isEditMode ? "Edit Laptop" : "Tambah Laptop Baru",
          style: const TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Form(
              // <--- WRAP DENGAN WIDGET FORM
              key: formKey, // Pasang Kunci Validasi
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInput(nameCtrl, "Nama Laptop", TextInputType.text),
                  _buildInput(
                    brandCtrl,
                    "Brand (Lenovo, HP, etc)",
                    TextInputType.text,
                  ),
                  _buildInput(
                    priceCtrl,
                    "Harga (Angka saja)",
                    TextInputType.number,
                    isNumber: true,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildInput(
                          ramCtrl,
                          "RAM (GB)",
                          TextInputType.number,
                          isNumber: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInput(
                          storageCtrl,
                          "SSD (GB)",
                          TextInputType.number,
                          isNumber: true,
                        ),
                      ),
                    ],
                  ),

                  _buildInput(
                    scoreCtrl,
                    "Benchmark Score (CPU)",
                    TextInputType.number,
                    isNumber: true,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildInput(
                          weightCtrl,
                          "Berat (Kg)",
                          TextInputType.number,
                          isNumber: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInput(
                          battCtrl,
                          "Baterai (Jam)",
                          TextInputType.number,
                          isNumber: true,
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: Colors.grey),
                  const Text(
                    "Detail Spesifikasi",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  _buildInput(
                    procNameCtrl,
                    "Nama Processor",
                    TextInputType.text,
                  ),
                  _buildInput(gpuCtrl, "GPU / VGA", TextInputType.text),
                  _buildInput(screenCtrl, "Layar", TextInputType.text),
                  _buildInput(imageCtrl, "Path Gambar", TextInputType.text),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE94560),
            ),
            onPressed: () {
              // --- JALANKAN VALIDASI ---
              if (formKey.currentState!.validate()) {
                // Jika validasi sukses, baru simpan data

                Laptop newLaptopData = Laptop(
                  id: isEditMode
                      ? laptopToEdit.id
                      : DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameCtrl.text,
                  brand: brandCtrl.text,
                  price: double.parse(priceCtrl.text),
                  ram: int.parse(ramCtrl.text),
                  storage: int.parse(storageCtrl.text),
                  processorScore: int.parse(scoreCtrl.text),
                  weight: double.parse(weightCtrl.text),
                  batteryLife: int.parse(battCtrl.text),
                  processorName: procNameCtrl.text,
                  gpu: gpuCtrl.text,
                  screenSize: screenCtrl.text,
                  imageAsset: imageCtrl.text,
                  linkUrl: "https://google.com",
                );

                setState(() {
                  if (isEditMode) {
                    laptopList[index!] = newLaptopData;
                  } else {
                    laptopList.add(newLaptopData);
                  }
                });

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEditMode ? "Data Diupdate!" : "Laptop Ditambah!",
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: Text(
              isEditMode ? "Update" : "Simpan",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper dengan VALIDATOR
  Widget _buildInput(
    TextEditingController ctrl,
    String label,
    TextInputType type, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        // Ubah TextField jadi TextFormField
        controller: ctrl,
        keyboardType: type,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE94560)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ), // Border merah kalau error
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.black26,
          isDense: true,
        ),
        // --- LOGIC VALIDASI DI SINI ---
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label wajib diisi';
          }
          if (isNumber) {
            // Cek apakah angka valid
            if (double.tryParse(value) == null) {
              return 'Harus angka';
            }
            // Cek apakah minus
            if (double.parse(value) < 0) {
              return 'Tidak boleh minus';
            }
          }
          return null; // Null artinya aman (valid)
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text("Admin Database"),
        backgroundColor: const Color(0xFF1A1A2E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE94560),
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: laptopList.isEmpty
          ? const Center(
              child: Text(
                "Belum ada data.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: laptopList.length,
              itemBuilder: (context, index) {
                final laptop = laptopList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: const Color(0xFF16213E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        laptop.imageAsset,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey,
                          width: 50,
                          height: 50,
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    title: Text(
                      laptop.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rp ${NumberFormat('#,###', 'id_ID').format(laptop.price)}",
                          style: const TextStyle(color: Color(0xFFE94560)),
                        ),
                        Text(
                          "RAM ${laptop.ram}GB | ${laptop.gpu}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => _showFormDialog(
                            laptopToEdit: laptop,
                            index: index,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => _deleteLaptop(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
