import '../models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Student>> fetchStudentsFromDatabase() async {
  final response = await http.get(Uri.parse('https://students-8a3ec-default-rtdb.firebaseio.com/students.json'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    
    print('Fetched data: $data');
    
    List<Student> students = [];
    data.forEach((key, value) {
      students.add(Student.fromJson(value));
    });
    
    return students;
  } else {
    throw Exception('Failed to load students');
  }
}

Future<void> addStudentToDatabase(Student student) async {
  final url = Uri.parse('https://students-8a3ec-default-rtdb.firebaseio.com/students.json');
  
  final studentData = {
      'firstName': student.firstName,
      'lastName': student.lastName,
      'gender': student.gender.toString(),
      'grade': student.grade,
      'department': 'dept.DepartmentType.${student.department.toString().split('.').last}',
  };

  try {
    final response = await http.post(
      url,
      body: json.encode(studentData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add student');
    }
  } catch (e) {
    print('Error adding student: $e');
  }
}

Future<void> deleteStudentFromDatabase(String key) async {
  final url = Uri.parse('https://students-8a3ec-default-rtdb.firebaseio.com/students/$key.json');

  try {
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  } catch (e) {
    print('Error deleting student: $e');
  }
}

 Future<void> updateStudentInDatabase(String key, Student student) async {
    final url = Uri.parse('https://students-8a3ec-default-rtdb.firebaseio.com/students/$key.json');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'firstName': student.firstName,
          'lastName': student.lastName,
          'gender': student.gender.toString(),
          'grade': student.grade,
          'department': 'dept.DepartmentType.${student.department.toString().split('.').last}',
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update student');
      }
    } catch (e) {
      print('Error updating student: $e');
    }
  }
