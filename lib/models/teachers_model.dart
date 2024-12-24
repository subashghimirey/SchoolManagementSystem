import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String position;
  final String department;
  final List<String> subjects; // List of subjects taught
  final Map<String, dynamic> attendance; // Attendance data
  final double salary;
  final String notes;

  Teacher({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.position,
    required this.department,
    required this.subjects,
    required this.attendance,
    required this.salary,
    required this.notes,
  });

  // Factory constructor to create Teacher from Firestore data
  factory Teacher.fromFirestore(
      Map<String, dynamic> firestoreData, String docId) {
    return Teacher(
      id: docId,
      name: firestoreData['name'] ?? '',
      age: firestoreData['age'] ?? 0,
      gender: firestoreData['gender'] ?? '',
      phone: firestoreData['phone'] ?? '',
      email: firestoreData['email'] ?? '',
      position: firestoreData['position'] ?? '',
      department: firestoreData['department'] ?? '',
      subjects: List<String>.from(firestoreData['subjects'] ?? []),
      attendance: firestoreData['attendance'] ?? {},
      salary: firestoreData['salary'] ?? 0.0,
      notes: firestoreData['notes'] ?? '',
    );
  }

  // Method to convert Teacher to Firestore data format
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'email': email,
      'position': position,
      'department': department,
      'subjects': subjects,
      'attendance': attendance,
      'salary': salary,
      'notes': notes,
    };
  }
}
