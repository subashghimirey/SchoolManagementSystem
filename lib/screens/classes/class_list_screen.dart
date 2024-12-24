import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/widgets/bottom_nav_bar.dart';
import 'section_list_screen.dart'; // To navigate to sections

class ClassListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch unique classes from Firestore
  Future<List<String>> _fetchClasses() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('students').get();

      // Safely extract unique classes
      Set<String> classes = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            // Extracting the class name with null check
            return data['class_info']?['current_class'] as String?;
          })
          .where((className) => className != null) // Filter out nulls
          .cast<String>() // Cast to String
          .toSet();

      return classes.toList();
    } catch (e) {
      throw Exception("Error fetching classes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
        // Adding a back button to navigate to the home screen
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // Navigate back to the home screen (replace 'HomeScreen' with your actual home screen widget)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No classes found.'));
          }

          List<String> classes = snapshot.data!;
          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final className = classes[index];
              return ListTile(
                title: Text('Class: $className'),
                onTap: () {
                  // Navigate to Section List Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SectionListScreen(className: className),
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
