import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/models/teachers_model.dart';
import 'package:sms_app/screens/teachers/add_teachers.dart';
import 'package:sms_app/screens/teachers/teachers_detail_screen.dart';
import 'package:sms_app/widgets/bottom_nav_bar.dart';

class TeacherListScreen extends StatefulWidget {
  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch teachers from Firestore
  Future<List<Teacher>> _fetchTeachers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('teachers').get();
    return querySnapshot.docs.map((doc) {
      return Teacher.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // This will navigate back to the previous screen
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to Add Teacher Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTeacherScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Teacher>>(
        future: _fetchTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No teachers found.'));
          }

          // Teacher List
          List<Teacher> teachers = snapshot.data!;
          return ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return ListTile(
                title: Text(teacher.name),
                subtitle: Text('Position: ${teacher.position}'),
                onTap: () {
                  // Navigate to Teacher Details Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TeacherDetailsScreen(teacher: teacher),
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
