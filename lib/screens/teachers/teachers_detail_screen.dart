import 'package:flutter/material.dart';
import 'package:sms_app/models/teachers_model.dart';
import 'package:sms_app/screens/teachers/edit_teacher_details.dart';


class TeacherDetailsScreen extends StatelessWidget {
  final Teacher teacher;

  const TeacherDetailsScreen({Key? key, required this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to Edit Teacher Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTeacherScreen(teacher: teacher),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${teacher.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Position: ${teacher.position}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${teacher.email}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${teacher.phone}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
