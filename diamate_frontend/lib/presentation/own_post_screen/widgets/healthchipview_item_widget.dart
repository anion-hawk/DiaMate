import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

class HealthchipviewItemWidget extends StatefulWidget {
  const HealthchipviewItemWidget({Key? key}) : super(key: key);

  @override
  _HealthchipviewItemWidgetState createState() =>
      _HealthchipviewItemWidgetState();
}

class _HealthchipviewItemWidgetState extends State<HealthchipviewItemWidget> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Health', 'Entertainment', 'Sports'];

    return Column(
      children: [
        Container(
          height: 100.0, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(
                    options[index],
                    style: TextStyle(
                      color: selectedOptions.contains(options[index])
                          ? Colors.white // Set text color to white when selected
                          : theme.colorScheme.primary,
                      fontSize: 12.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: selectedOptions.contains(options[index]),
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
                        selectedOptions.add(options[index]);
                      } else {
                        selectedOptions.remove(options[index]);
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.0),
        // ElevatedButton(
        //   onPressed: () {
        //     // Add your logic for the "Add" button here
        //     print('Selected Options: $selectedOptions');
        //   },
        //   child: Text('Add'),
        // ),
      ],
    );
  }
}
