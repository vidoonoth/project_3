import 'package:flutter/material.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';

class Pengusulan extends StatefulWidget {
  const Pengusulan({super.key});

  @override
  State<Pengusulan> createState() => _PengusulanState();
}

class _PengusulanState extends State<Pengusulan> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _pengarangController = TextEditingController();
  final TextEditingController _penerbitController = TextEditingController();
  final TextEditingController _tahunTerbitController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _isbnController.dispose();
    _pengarangController.dispose();
    _penerbitController.dispose();
    _tahunTerbitController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  void _submitForm() {
    String judul = _judulController.text;
    String isbn = _isbnController.text;
    String pengarang = _pengarangController.text;
    String penerbit = _penerbitController.text;
    String tahunTerbit = _tahunTerbitController.text;
    String kategori = _kategoriController.text;

    if (judul.isNotEmpty &&
        isbn.isNotEmpty &&
        pengarang.isNotEmpty &&
        penerbit.isNotEmpty &&
        tahunTerbit.isNotEmpty &&
        kategori.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usulan Buku '$judul' berhasil dikirim!")),
      );

      _judulController.clear();
      _isbnController.clear();
      _pengarangController.clear();
      _penerbitController.clear();
      _tahunTerbitController.clear();
      _kategoriController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Mohon isi semua field!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pengusulan Buku"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Usulan", icon: Icon(Icons.book)),
              Tab(text: "Riwayat Usulan", icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Halaman pertama: Form Pengusulan
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(_judulController, "Judul Buku"),
                    _buildTextField(_isbnController, "ISBN"),
                    _buildTextField(_pengarangController, "Pengarang"),
                    _buildTextField(_penerbitController, "Penerbit"),
                    _buildTextField(
                      _tahunTerbitController,
                      "Tahun Terbit",
                      keyboardType: TextInputType.number,
                    ),
                    _buildTextField(_kategoriController, "Kategori"),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Kirim Usulan"),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Halaman kedua: Riwayat Usulan
            Center(
              child: Text(
                "Riwayat Usulan Anda akan muncul di sini.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavComponent(
          selectedIndex:
              2, // Pastikan ini sesuai dengan indeks halaman Dashboard
          onItemTapped: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/dashboard');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/buku');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/usulan');
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, '/informasi');
            } else if (index == 4) {
              Navigator.pushReplacementNamed(context, '/profil');
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
