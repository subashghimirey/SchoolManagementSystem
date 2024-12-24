import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/models/student_model.dart';
import 'package:sms_app/screens/students/Single_student_view.dart'; // Ensure this import is correct

class StudentListScreen extends StatelessWidget {
  final String className;
  final String section;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StudentListScreen({required this.className, required this.section});

  // Fetch students for the given class and section
  Future<List<Student>> _fetchStudents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('students')
          .where('class_info.current_class', isEqualTo: className)
          .where('class_info.section', isEqualTo: section)
          .get();

      return querySnapshot.docs.map((doc) {
        // Safely map Firestore document to the Student model
        return Student.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching students: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students - $className $section')),
      body: FutureBuilder<List<Student>>(
        future: _fetchStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students found.'));
          }

          List<Student> students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text(student.name),
                subtitle: Text(
                    'Roll No: ${student.rollNo}, Section: ${student.section}'),
                onTap: () {
                  
                  // Navigate to Student Details Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleStudentView(student: student),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
