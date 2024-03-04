import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

class StaticChoiceChips extends StatefulWidget {
  //final void Function(List<String> selectedOptions) onOptionsChanged;
  final List<String> options;

  const StaticChoiceChips({Key? key, required this.options}) : super(key: key);

  @override
  _StaticChoiceChips createState() => _StaticChoiceChips();
}

class _StaticChoiceChips extends State<StaticChoiceChips> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    final List<String> options = widget.options;

    return Column(children: [
      Wrap(
          spacing: 8.0, // Adjust the spacing between chips
          runSpacing: 8.0, // Adjust the spacing between rows
          children: options.map((option) {
            return ChoiceChip(
              label: Text(
                option,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: selectedOptions.contains(option),
              backgroundColor: theme.colorScheme.primary,
              selectedColor: theme
                  .colorScheme.primary, // Set background color when selected
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(13.0),
              ),
              onSelected: (bool selected) {},
            );
          }).toList())
    ]);
  }
}
