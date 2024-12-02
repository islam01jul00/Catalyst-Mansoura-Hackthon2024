import 'package:flutter/material.dart';
import '../../../data/models/question/option.dart';

class CustomChoose extends StatelessWidget {
  const CustomChoose({
    super.key,
    required this.isSelected,
    required this.option,
  });

  final bool isSelected;
  final Option option;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              option.text!, // Access the `text` field from the `Option` model
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey[800],
              ),
            ),
          ),
          if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }
}
