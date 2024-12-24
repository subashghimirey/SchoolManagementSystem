import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms_app/models/teachers_model.dart';
import 'package:sms_app/screens/teachers/teachers_screen.dart';


class AddTeacherScreen extends StatefulWidget {
  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  List<String> _subjects = [];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Teacher newTeacher = Teacher(
        id: '',
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: 'Not specified', // You can adjust this based on your needs
        phone: _phoneController.text,
        email: _emailController.text,
        position: _positionController.text,
        department: _departmentController.text,
        subjects: _subjects,
        attendance: {},
        salary: double.parse(_salaryController.text),
        notes: _notesController.text,
      );

      try {
        // Add new teacher to Firestore
        await _firestore.collection('teachers').add(newTeacher.toFirestore());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherListScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Teacher added successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to add teacher: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the teacher\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the teacher\'s age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
              ),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(labelText: 'Department'),
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              // Subjects input (for simplicity, we're using a text field for now)
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Subjects (comma separated)'),
                onChanged: (value) {
                  _subjects = value.split(',').map((e) => e.trim()).toList();
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Teacher'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
