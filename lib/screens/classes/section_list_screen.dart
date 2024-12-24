import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/screens/classes/student_list_screen_CS.dart'; // To navigate to students

class SectionListScreen extends StatelessWidget {
  final String className;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SectionListScreen({required this.className});

  Future<List<String>> _fetchSections() async {
    try {
      // Fetch students based on the class name
      QuerySnapshot querySnapshot = await _firestore
          .collection('students')
          .where('class_info.current_class', isEqualTo: className)
          .get();

      // Safely extract unique sections from student data
      Set<String> sections = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['class_info']?['section'] as String?;
          })
          .where((section) => section != null) // Filter out null sections
          .cast<String>() // Cast to String
          .toSet();

      return sections.toList();
    } catch (e) {
      throw Exception("Error fetching sections: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sections - Class $className')),
      body: FutureBuilder<List<String>>(
        future: _fetchSections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sections found.'));
          }

          List<String> sections = snapshot.data!;
          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return ListTile(
                title: Text('Section: $section'),
                onTap: () {
                  // Navigate to Student List Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentListScreen(
                        className: className,
                        section: section,
                      ),
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
