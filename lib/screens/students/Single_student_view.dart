import 'package:flutter/material.dart';
import 'package:sms_app/models/student_model.dart';

class SingleStudentView extends StatelessWidget {
  final Student student;

  // Constructor to accept student data
  SingleStudentView({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${student.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${student.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Age: ${student.age}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Class: ${student.currentClass}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Section: ${student.section}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Phone: ${student.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${student.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Roll No: ${student.rollNo}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Average Grade: ${student.averageGrade}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            // Add more fields as required
          ],
        ),
      ),
    );
  }
}
