import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'result_page.dart';
import 'admin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _budgetController = TextEditingController();
  String _selectedCategory = 'Coding / Dev';
  final List<String> _categories = [
    'Coding / Dev',
    'Gaming / Berat',
    'Desain Grafis',
    'Office / Kuliah',
  ];

  // FITUR: Rekomendasi Harga Minimal (Logic)
  String _getPriceHint() {
    switch (_selectedCategory) {
      case 'Gaming / Berat':
        return "Minimal Rp 10.000.000 untuk performa lancar.";
      case 'Desain Grafis':
        return "Minimal Rp 7.000.000 untuk akurasi warna.";
      case 'Coding / Dev':
        return "Minimal Rp 5.000.000 untuk multitasking.";
      case 'Office / Kuliah':
        return "Minimal Rp 3.000.000 sudah cukup.";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // GRADIENT BACKGROUND FULL SCREEN
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027), // Deep Space
              Color(0xFF203A43), // Deep Teal
              Color(0xFF2C5364), // Dark Blue
            ],
          ),
        ),
        child: SafeArea(
          // Biar gak ketutup status bar
          child: Column(
            children: [
              // HEADER (Ganti judul Elite jadi nama App)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "LaptopSpec Matcher",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white70,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AdminPage()),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Cari Laptop,\nSesuai Dompet.",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // DROPDOWN
                          const Text(
                            "Kebutuhan Utama",
                            style: TextStyle(
                              color: Color(0xFF4CA1AF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                dropdownColor: const Color(
                                  0xFF203A43,
                                ), // Warna dropdown ngikut tema
                                isExpanded: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                items: _categories
                                    .map(
                                      (val) => DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedCategory = val!),
                              ),
                            ),
                          ),

                          // FITUR: HARGA MINIMAL TEXT
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 4),
                            child: Text(
                              "💡 Tips: ${_getPriceHint()}",
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // INPUT BUDGET
                          const Text(
                            "Budget Maksimal (IDR)",
                            style: TextStyle(
                              color: Color(0xFF4CA1AF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _budgetController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              prefixText: "Rp ",
                              prefixStyle: const TextStyle(color: Colors.white),
                              hintText: "Contoh: 5.000.000",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (val) => (val == null || val.isEmpty)
                                ? "Wajib diisi"
                                : null,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                          ),

                          const SizedBox(height: 50),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE94560),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  String cleanBudget = _budgetController.text
                                      .replaceAll('.', '');
                                  double budgetValue = double.parse(
                                    cleanBudget,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultPage(
                                        budget: budgetValue,
                                        category: _selectedCategory,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "CARI LAPTOP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FORMATTER RUPIAH CUSTOM
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return newValue;
    double value = double.parse(newValue.text);
    final formatter = NumberFormat('#,###', 'id_ID');
    String newText = formatter.format(value);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
