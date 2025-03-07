import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Hapus token dari SharedPreferences
    Navigator.pushReplacementNamed(context, '/login'); // Arahkan ke login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto profil
            Container(
              width: 160, // Ukuran avatar sesuai dengan radius x 2
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/alfin.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Nama dan tanggal bergabung
            Text(
              "Gracia",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Bergabung pada 10 Jan 2025",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Informasi pengguna
            _buildInfoRow("Username", "Gracia"),
            _buildInfoRow("Nama lengkap", "gracia victory"),
            _buildInfoRow("NIK", "45393429319931311"),
            _buildInfoRow("Nomor telepon", "08xxxxxxxxxxxx"),
            _buildInfoRow("Jenis kelamin", "perempuan"),
            SizedBox(height: 30),

            // Tombol Edit Profil
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text("edit", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("atau", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _logout,
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  label: Text("keluar", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavComponent(
        selectedIndex: 4,
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
    );
  }

  // Fungsi untuk membuat baris informasi profil
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
