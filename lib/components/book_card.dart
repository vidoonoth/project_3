import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final List<Map<String, String>> books;

  const BookCard({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 238, 241),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      books[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  books[index]['title']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
