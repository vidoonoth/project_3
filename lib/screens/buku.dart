import 'package:flutter/material.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/book_card.dart';

class BukuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final books = [
      {'title': 'Bintang', 'image': 'assets/bookimages/bintang.jpeg'},
      {'title': 'Hujan', 'image': 'assets/bookimages/hujan.jpeg'},
      {
        'title': 'Laut Bercerita',
        'image': 'assets/bookimages/laut_bercerita.jpg',
      },
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Buku')),
      body: BookCard(books: books),
      bottomNavigationBar: BottomNavComponent(
        selectedIndex: 1, // Pastikan ini sesuai dengan indeks halaman Dashboard
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
}
