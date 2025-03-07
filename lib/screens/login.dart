import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Email dan password tidak boleh kosong!");
      return;
    }

    isLoading.value = true; // Mengubah state dengan ValueNotifier

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.24:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          _showSnackBar("Login berhasil, tetapi token tidak ditemukan.");
        }
      } else {
        _showSnackBar("Login gagal: ${response.body}");
      }
    } catch (e) {
      _showSnackBar("Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo dan Judul
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/perpus_logo.svg',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perpustakaan',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Indramayu',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Input Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email atau nomor telepon',
                  hintText: 'Masukkan email atau nomor telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),

              // Input Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),

              // Teks Daftar dan Lupa Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      "Belum punya akun? Daftar",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lupa kata sandi?",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Tombol Login
              ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, loading, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          loading
                              ? null
                              : () => login(
                                emailController.text,
                                passwordController.text,
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child:
                          loading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                'Masuk',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Divider "atau login dengan"
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "atau login dengan",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Tombol Login Google
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {}, // Tambahkan fungsi login Google jika ada
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login dengan",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      Image.asset('assets/google_logo.svg.png', height: 20),
                    ],
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
