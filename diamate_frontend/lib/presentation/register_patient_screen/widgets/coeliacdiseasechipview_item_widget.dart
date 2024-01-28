import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

class DiseaseWidget extends StatefulWidget {
  const DiseaseWidget({Key? key}) : super(key: key);

  @override
  _DiseaseWidget createState() => _DiseaseWidget();
}

class _DiseaseWidget extends State<DiseaseWidget> {
  
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Coeliac disease', 'Thyroid disease', 'Polycystic Ovary syndrome', 'Eye Cataract', 'Diabetes insipidus', 'Insulin resistance', 'High blood pressure'];

    return Column(
      children: [
        Container(
          height: 100.0, // Adjust the height as needed
          child: Wrap(
            spacing: 8.0, // Adjust the spacing between chips
            runSpacing: 8.0, // Adjust the spacing between rows
            children: options.map((option) {
              return ChoiceChip(
                label: Text(
                  option,
                  style: TextStyle(
                    color: selectedOptions.contains(option)
                        ? Colors.white // Set text color to white when selected
                        : theme.colorScheme.primary,
                    fontSize: 12.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: selectedOptions.contains(option),
                backgroundColor: Colors.transparent,
                selectedColor: theme.colorScheme.primary, // Set background color when selected
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}




