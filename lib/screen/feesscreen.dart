import 'package:flutter/material.dart';

class FeesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fees Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Outstanding Fees', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            _buildFeeCard('Tuition Fee', '10,000 USD', 'Due: 15th June 2025', false),
            _buildFeeCard('Library Fee', '500 USD', 'Paid on: 1st May 2025', true),
            _buildFeeCard('Lab Fee', '300 USD', 'Due: 10th June 2025', false),
            
            const SizedBox(height: 20),
            Text('Payment History', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            _buildHistoryCard('Library Fee', '500 USD', '1st May 2025'),
            
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to Payment Page
              },
              icon: const Icon(Icons.credit_card),
              label: const Text('Proceed to Payment'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeCard(String title, String amount, String status, bool isPaid) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          isPaid ? Icons.check_circle : Icons.error,
          color: isPaid ? Colors.green : Colors.red,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: Text(amount, style: TextStyle(color: isPaid ? Colors.green : Colors.red)),
      ),
    );
  }

  Widget _buildHistoryCard(String title, String amount, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.history, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Paid on: $date'),
        trailing: Text(amount, style: const TextStyle(color: Colors.blue)),
      ),
    );
  }
}

