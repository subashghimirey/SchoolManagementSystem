import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms_app/models/student_model.dart'; // Import your model

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form controllers for inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentClassController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _averageGradeController = TextEditingController();
  final TextEditingController _monthlyAttendanceController =
      TextEditingController();
  final TextEditingController _yearlyAttendanceController =
      TextEditingController();
  final TextEditingController _totalFeesController = TextEditingController();
  final TextEditingController _paidFeesController = TextEditingController();
  final TextEditingController _pendingFeesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Function to add data to Firestore
  Future<void> _addStudentData() async {
    try {
      // Creating a Student object based on the data entered
      Student newStudent = Student(
        id: _nameController
            .text, // You can use a unique ID like document ID if you prefer
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _genderController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        currentClass: _currentClassController.text,
        section: _sectionController.text,
        rollNo: _rollNoController.text,
        examResults: [], // Add actual exam results as a list of ExamResult objects
        averageGrade: _averageGradeController.text,
        monthlyAttendance: {
          'January': int.tryParse(_monthlyAttendanceController.text) ?? 0,
        },
        yearlyAttendance: int.tryParse(_yearlyAttendanceController.text) ?? 0,
        totalFees: int.tryParse(_totalFeesController.text) ?? 0,
        paidFees: int.tryParse(_paidFeesController.text) ?? 0,
        pendingFees: int.tryParse(_pendingFeesController.text) ?? 0,
        notes: _notesController.text,
      );

      // Adding the student to Firestore
      String sanitizedStudentName = newStudent.name.replaceAll(' ', '_');

      await _firestore
          .collection('students')
          .doc(
              '${newStudent.currentClass}_${newStudent.rollNo}_$sanitizedStudentName')
          .set(newStudent.toFirestore());


      // Clear the text fields after submission
      _nameController.clear();
      _ageController.clear();
      _genderController.clear();
      _phoneController.clear();
      _emailController.clear();
      _currentClassController.clear();
      _sectionController.clear();
      _rollNoController.clear();
      _averageGradeController.clear();
      _monthlyAttendanceController.clear();
      _yearlyAttendanceController.clear();
      _totalFeesController.clear();
      _paidFeesController.clear();
      _pendingFeesController.clear();
      _notesController.clear();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added successfully!')),
      );

      
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add student: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Mandatory Fields
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name *'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age *'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender *'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone *'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email *'),
              ),
              TextField(
                controller: _currentClassController,
                decoration: InputDecoration(labelText: 'Current Class *'),
              ),
              TextField(
                controller: _sectionController,
                decoration: InputDecoration(labelText: 'Section *'),
              ),
              TextField(
                controller: _rollNoController,
                decoration: InputDecoration(labelText: 'Roll No *'),
              ),
        
              // Optional Fields
              TextField(
                controller: _averageGradeController,
                decoration: InputDecoration(
                    labelText: 'Average Grade (Optional)',
                    hintText: 'Enter average grade'),
              ),
              TextField(
                controller: _monthlyAttendanceController,
                decoration: InputDecoration(
                    labelText: 'Monthly Attendance (Optional)',
                    hintText: 'Enter attendance for a specific month'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _yearlyAttendanceController,
                decoration: InputDecoration(
                    labelText: 'Yearly Attendance (Optional)',
                    hintText: 'Enter total yearly attendance'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _totalFeesController,
                decoration: InputDecoration(
                    labelText: 'Total Fees (Optional)',
                    hintText: 'Enter total fees'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _paidFeesController,
                decoration: InputDecoration(
                    labelText: 'Paid Fees (Optional)',
                    hintText: 'Enter paid fees'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _pendingFeesController,
                decoration: InputDecoration(
                    labelText: 'Pending Fees (Optional)',
                    hintText: 'Enter pending fees'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                    labelText: 'Notes (Optional)',
                    hintText: 'Enter any notes or remarks'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addStudentData,
                child: Text('Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
