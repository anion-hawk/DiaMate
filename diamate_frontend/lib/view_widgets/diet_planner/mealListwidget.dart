import 'package:flutter/material.dart';
import 'package:diamate_frontend/core/app_export.dart';
//UserprofilelistItemWidget
class UserMeallistItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  const UserMeallistItemWidget({required this.data, Key? key}) : super(key: key);

  @override
  _MedicationModalState createState() => _MedicationModalState();
}

class _MedicationModalState extends State<UserMeallistItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['sformatted_time']+' - '+widget.data['sformatted_time'],
                //'08:00 AM - 09:10 AM', // Time range text
                style: TextStyle(
                  color: Color(0xFF012b68),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                widget.data['formatted_date'],
                //'08:00 AM - 09:10 AM', // Time range text
                style: TextStyle(
                  color: Color(0xFF012b68),
                ),
              ), SizedBox(height:10)
            ],
          ),
          SizedBox(width: 10.0), // Add some space between time range and box
          Container(
            width: 220.0,
            // Set width of the box
            decoration: BoxDecoration(
              color: Color(0xFF012b68),
              borderRadius: BorderRadius.circular(10.0), // Set border radius
            ),
           padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data['type'], // Text inside the box
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  widget.data['title'], // Text inside the box
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
