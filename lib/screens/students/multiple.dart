import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms_app/models/student_model.dart';
import 'package:sms_app/widgets/bottom_nav_bar.dart'; // Import your model

class AddMultipleStudentsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sample student data
  final List<Student> sampleStudents = [
    Student(
      id: '1',
      name: 'Foss Folini',
      age: 76,
      gender: 'Male',
      phone: '268-628-7068',
      email: 'ffolini3@barnesandnoble.com',
      currentClass: '4',
      section: 'A',
      rollNo: '37',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 37},
      yearlyAttendance: 37,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Good student',
    ),
    Student(
      id: '2',
      name: 'Roanna Kyle',
      age: 68,
      gender: 'Female',
      phone: '225-374-3718',
      email: 'rkyle4@harvard.edu',
      currentClass: '3',
      section: 'A',
      rollNo: '30',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 30},
      yearlyAttendance: 30,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Excellent performance',
    ),
    Student(
      id: '3',
      name: 'Maurizia Dugmore',
      age: 59,
      gender: 'Female',
      phone: '813-292-9662',
      email: 'mdugmore5@pcworld.com',
      currentClass: '10',
      section: 'A',
      rollNo: '35',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 35},
      yearlyAttendance: 35,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Good student',
    ),
    Student(
      id: '4',
      name: 'Jacinta McKintosh',
      age: 86,
      gender: 'Female',
      phone: '979-200-7007',
      email: 'jmckintosh6@google.cn',
      currentClass: '12',
      section: 'A',
      rollNo: '3',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 3},
      yearlyAttendance: 3,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Needs improvement',
    ),
    Student(
      id: '5',
      name: 'Karmen Popescu',
      age: 28,
      gender: 'Female',
      phone: '394-384-2089',
      email: 'kpopescu7@mapy.cz',
      currentClass: '1',
      section: 'A',
      rollNo: '15',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 15},
      yearlyAttendance: 15,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Hardworking student',
    ),
    Student(
      id: '6',
      name: 'Salvatore McNaughton',
      age: 8,
      gender: 'Male',
      phone: '902-255-8860',
      email: 'smcnaughton8@shutterfly.com',
      currentClass: '2',
      section: 'A',
      rollNo: '41',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 41},
      yearlyAttendance: 41,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Excellent student',
    ),
    Student(
      id: '7',
      name: 'Kerri Zanneli',
      age: 54,
      gender: 'Female',
      phone: '908-772-8324',
      email: 'kzanneli9@umich.edu',
      currentClass: '12',
      section: 'A',
      rollNo: '22',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 22},
      yearlyAttendance: 22,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Good performance',
    ),
    Student(
      id: '8',
      name: 'Lynna Karlmann',
      age: 22,
      gender: 'Female',
      phone: '490-216-3082',
      email: 'lkarlmanna@hibu.com',
      currentClass: '7',
      section: 'A',
      rollNo: '3',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 3},
      yearlyAttendance: 3,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Good student',
    ),
    Student(
      id: '9',
      name: 'Birgit McCrow',
      age: 30,
      gender: 'Female',
      phone: '756-787-5049',
      email: 'bmccrowb@weibo.com',
      currentClass: '10',
      section: 'A',
      rollNo: '42',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 42},
      yearlyAttendance: 42,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Consistent performer',
    ),
    Student(
      id: '10',
      name: 'Clotilda Lant',
      age: 88,
      gender: 'Female',
      phone: '104-725-9235',
      email: 'clantc@ox.ac.uk',
      currentClass: '9',
      section: 'A',
      rollNo: '38',
      examResults: [],
      averageGrade: 'A',
      monthlyAttendance: {'January': 38},
      yearlyAttendance: 38,
      totalFees: 5000,
      paidFees: 3000,
      pendingFees: 2000,
      notes: 'Good student',
    ),

    // Add other sample students in a similar way...
  ];

  // Function to add sample students to Firestore
  Future<void> addSampleData(BuildContext context) async {
    try {
      // Loop through the sample students and add them to Firestore
      for (var student in sampleStudents) {
        String sanitizedStudentName = student.name.replaceAll(' ', '_');
        await _firestore
            .collection('students')
            .doc(
                '${student.currentClass}_${student.rollNo}_$sanitizedStudentName')
            .set(student.toFirestore());
      }

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sample data added successfully!')),
      );
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add sample data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Multiple Students'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()),); // This will navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () => addSampleData(context), // Pass context here
            child: Text('Add Sample Data'),
          ),
        ),
      ),
    );
  }
}
