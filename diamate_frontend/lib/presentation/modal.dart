import 'dart:js';

import 'package:flutter/material.dart';

class FirstModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Modal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showSecondModal(context);
          },
          child: Text('Open Second Modal'),
        ),
      ),
    );
  }

  void _showSecondModal(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return SecondModal();
      },
    );

    // Handle the result from the second modal
    if (result != null) {
      Navigator.pop(context, result); // Close the first modal and pass the result
    }
  }
}

class SecondModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select an Option',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildOptionButton(context, 'Option 1'),
          _buildOptionButton(context, 'Option 2'),
          _buildOptionButton(context, 'Option 3'),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String option) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context, option); // Close the second modal and pass the selected option
      },
      child: Text(option),
    );
  }
}

void main() {

  runApp(MaterialApp(
    
    home: Scaffold(
      
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        
        child: ElevatedButton(
          onPressed: () {
            
            _showFirstModal(context as BuildContext);
          },
          child: Text('Open First Modal'),
        ),
      ),
    ),
  ));
}

void _showFirstModal(BuildContext context) async {
  final result = await showModalBottomSheet<String>(
    context: context,
    builder: (BuildContext context) {
      return FirstModal();
    },
  );

  // Handle the result from the first modal
  if (result != null) {
    print('Selected option from First Modal: $result');
  }
}
