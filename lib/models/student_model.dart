import 'package:flutter/foundation.dart';

class ExamResult {
  final String subject;
  final double marks;
  final String grade;

  const ExamResult({
    required this.subject,
    required this.marks,
    required this.grade,
  });

  factory ExamResult.fromMap(Map<String, dynamic> map) {
    return ExamResult(
      subject: map['subject'] ?? '',
      marks: (map['marks'] is num) ? (map['marks'] as num).toDouble() : 0.0,
      grade: map['grade'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'marks': marks,
      'grade': grade,
    };
  }
}

class Student {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String currentClass;
  final String section;
  final String rollNo;
  final List<ExamResult> examResults;
  final String averageGrade;
  final Map<String, int> monthlyAttendance;
  final int yearlyAttendance;
  final int totalFees;
  final int paidFees;
  final int pendingFees;
  final String notes;

  const Student({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.currentClass,
    required this.section,
    required this.rollNo,
    required this.examResults,
    required this.averageGrade,
    required this.monthlyAttendance,
    required this.yearlyAttendance,
    required this.totalFees,
    required this.paidFees,
    required this.pendingFees,
    required this.notes,
  });

  // Convert Firebase data to Student object
  factory Student.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Student(
      id: documentId,
      name: _safeString(data, ['name']),
      age: _safeInt(data, ['age']),
      gender: _safeString(data, ['gender']),
      phone: _safeString(data, ['contact_info', 'phone']),
      email: _safeString(data, ['contact_info', 'email']),
      currentClass: _safeString(data, ['class_info', 'current_class']),
      section: _safeString(data, ['class_info', 'section']),
      rollNo: _safeString(data, ['class_info', 'roll_no']),
      examResults: _safeExamResults(data, ['performance', 'exam_results']),
      averageGrade: _safeString(data, ['performance', 'average_grade']),
      monthlyAttendance: _safeIntMap(data, ['attendance', 'monthly']),
      yearlyAttendance: _safeInt(data, ['attendance', 'yearly']),
      totalFees: _safeInt(data, ['fee_details', 'total_fees']),
      paidFees: _safeInt(data, ['fee_details', 'paid']),
      pendingFees: _safeInt(data, ['fee_details', 'pending']),
      notes: _safeString(data, ['notes']),
    );
  }

  // Convert Student object to Firebase data
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'contact_info': {
        'phone': phone,
        'email': email,
      },
      'class_info': {
        'current_class': currentClass,
        'section': section,
        'roll_no': rollNo,
      },
      'performance': {
        'exam_results': examResults.map((result) => result.toMap()).toList(),
        'average_grade': averageGrade,
      },
      'attendance': {
        'monthly': monthlyAttendance,
        'yearly': yearlyAttendance,
      },
      'fee_details': {
        'total_fees': totalFees,
        'paid': paidFees,
        'pending': pendingFees,
      },
      'notes': notes,
    };
  }

  // Utility methods for safe data extraction
  static String _safeString(Map<String, dynamic> data, List<String> keys,
      {String defaultValue = ''}) {
    dynamic value = data;
    try {
      for (var key in keys) {
        value = value?[key];
      }
      return (value is String) ? value : defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static int _safeInt(Map<String, dynamic> data, List<String> keys,
      {int defaultValue = 0}) {
    dynamic value = data;
    try {
      for (var key in keys) {
        value = value?[key];
      }
      return (value is num) ? value.toInt() : defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Map<String, int> _safeIntMap(
      Map<String, dynamic> data, List<String> keys) {
    dynamic value = data;
    try {
      for (var key in keys) {
        value = value?[key];
      }
      return (value is Map)
          ? Map<String, int>.from(value.map(
              (k, v) => MapEntry(k.toString(), (v is num) ? v.toInt() : 0)))
          : {};
    } catch (_) {
      return {};
    }
  }

  static List<ExamResult> _safeExamResults(
      Map<String, dynamic> data, List<String> keys) {
    dynamic value = data;
    try {
      for (var key in keys) {
        value = value?[key];
      }
      return (value is List)
          ? value.map((result) => ExamResult.fromMap(result)).toList()
          : [];
    } catch (_) {
      return [];
    }
  }

  // Equality and hashCode for proper comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Student && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  // Optional: Create a copyWith method for easy modification
  Student copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? phone,
    String? email,
    String? currentClass,
    String? section,
    String? rollNo,
    List<ExamResult>? examResults,
    String? averageGrade,
    Map<String, int>? monthlyAttendance,
    int? yearlyAttendance,
    int? totalFees,
    int? paidFees,
    int? pendingFees,
    String? notes,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      currentClass: currentClass ?? this.currentClass,
      section: section ?? this.section,
      rollNo: rollNo ?? this.rollNo,
      examResults: examResults ?? this.examResults,
      averageGrade: averageGrade ?? this.averageGrade,
      monthlyAttendance: monthlyAttendance ?? this.monthlyAttendance,
      yearlyAttendance: yearlyAttendance ?? this.yearlyAttendance,
      totalFees: totalFees ?? this.totalFees,
      paidFees: paidFees ?? this.paidFees,
      pendingFees: pendingFees ?? this.pendingFees,
      notes: notes ?? this.notes,
    );
  }
}
