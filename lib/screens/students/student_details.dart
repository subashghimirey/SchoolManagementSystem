import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/models/student_model.dart';
import 'package:sms_app/screens/students/Single_student_view.dart';
import 'package:sms_app/widgets/bottom_nav_bar.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Filters
  String _searchQuery = '';
  String _selectedClass = '';
  String _selectedSection = '';

  // Future to fetch students from Firestore
  Future<List<Student>> _fetchStudents() async {
    QuerySnapshot querySnapshot = await _firestore.collection('students').get();
    return querySnapshot.docs.map((doc) {
      return Student.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Method to filter students based on search query and selected filters
  List<Student> _filterStudents(List<Student> students) {
    return students.where((student) {
      bool matchesName =
          student.name.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesClass =
          _selectedClass.isEmpty || student.currentClass == _selectedClass;
      bool matchesSection =
          _selectedSection.isEmpty || student.section == _selectedSection;

      return matchesName && matchesClass && matchesSection;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )); // This will navigate back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Filters Dropdowns
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                // Class Filter Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedClass.isEmpty ? null : _selectedClass,
                    hint: Text('Select Class'),
                    items: ['10', '11', '12'] // Example classes
                        .map((className) => DropdownMenuItem(
                              value: className,
                              child: Text(className),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedClass = value ?? '';
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                // Section Filter Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedSection.isEmpty ? null : _selectedSection,
                    hint: Text('Select Section'),
                    items: ['A', 'B', 'C'] // Example sections
                        .map((section) => DropdownMenuItem(
                              value: section,
                              child: Text(section),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSection = value ?? '';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // List of Students
          Expanded(
            child: FutureBuilder<List<Student>>(
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

                // Filter students based on search and filter values
                List<Student> filteredStudents =
                    _filterStudents(snapshot.data!);

                return ListView.builder(
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = filteredStudents[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the StudentDetailScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleStudentView(student: student),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                            'Class: ${student.currentClass} - Section: ${student.section}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
