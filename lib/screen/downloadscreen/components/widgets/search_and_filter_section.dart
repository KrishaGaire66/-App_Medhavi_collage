import 'package:flutter/material.dart';

class SearchAndFilterSection extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final Function(String) onSearchChanged;

  const SearchAndFilterSection({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Mathematics', 'Physics', 'Chemistry', 'Computer Science', 'English'];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3)],
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search question papers...',
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            onChanged: onSearchChanged,
          ),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (_) => onFilterSelected(filter),
                    backgroundColor: Colors.grey[200],
                    selectedColor: Colors.indigo[100],
                    checkmarkColor: Colors.indigo[600],
                    labelStyle: TextStyle(color: isSelected ? Colors.indigo[600] : Colors.grey[700]),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
