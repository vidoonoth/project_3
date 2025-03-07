import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> register() async {
    final String apiUrl = 'http://192.168.1.34:8000/api/register';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        }),
      );

      if (response.statusCode == 201) {
        showMessage('Registrasi berhasil!', Colors.green);
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        showMessage(responseData['message'] ?? 'Registrasi gagal!', Colors.red);
      }
    } catch (error) {
      showMessage('Terjadi kesalahan! Periksa koneksi Anda.', Colors.red);
    }
  }

  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                Text(
                  "Daftar",
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(nameController, "Nama Lengkap"),
                _buildTextField(usernameController, "Username"),
                _buildTextField(emailController, "Email atau nomor telepon"),
                _buildTextField(passwordController, "Password", obscureText: true),
                _buildTextField(confirmPasswordController, "Konfirmasi Password", obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Daftar',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Sudah punya akun? Masuk",
                    style: GoogleFonts.poppins(color: Colors.blueAccent, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      height: 60, // Atur tinggi input field
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Padding dalam
        ),
      ),
    ),
  );
}

}