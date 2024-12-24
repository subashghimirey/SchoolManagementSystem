import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/models/teachers_model.dart';
import 'package:sms_app/screens/teachers/teachers_screen.dart';

class EditTeacherScreen extends StatefulWidget {
  final Teacher teacher;

  const EditTeacherScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _positionController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.teacher.name);
    _positionController = TextEditingController(text: widget.teacher.position);
    _emailController = TextEditingController(text: widget.teacher.email);
    _phoneController = TextEditingController(text: widget.teacher.phone);
  }

  // Update teacher in Firestore
  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      await _firestore.collection('teachers').doc(widget.teacher.id).update({
        'name': _nameController.text,
        'position': _positionController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });

      // Show success message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher updated successfully')),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherListScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter the position' : null,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a valid email' : null,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a valid phone number' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateTeacher,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
