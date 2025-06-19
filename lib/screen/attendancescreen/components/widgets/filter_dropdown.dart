import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const FilterDropdown({super.key, required this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        underline: const SizedBox(),
        items: ['All', 'Present', 'Absent', 'Late']
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e, style: const TextStyle(fontSize: 12))))
            .toList(),
        onChanged: (value) => value != null ? onChanged(value) : null,
      ),
    );
  }
}
