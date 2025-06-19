import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medhavi/models/library_model.dart';
import 'package:medhavi/provider/library_provider.dart'; // adjust import path accordingly

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryAsyncValue = ref.watch(libraryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Library'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                // You can implement search/filter logic here
              },
            ),
          ),
          Expanded(
            child: libraryAsyncValue.when(
              data: (bookResponse) {
                final books = bookResponse.data ?? [];
                if (books.isEmpty) {
                  return const Center(child: Text('No books available'));
                }
                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookCard(book: book);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.book, size: 40, color: Colors.blue),
        title: Text(
          book.title ?? 'No Title',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Author: ${book.author ?? 'Unknown'}'),
        trailing: Chip(
          label: Text(
            (book.available ?? false) ? 'Available' : 'Checked out',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor:
              (book.available ?? false) ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
