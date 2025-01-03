import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/future_providers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
  (ref) => StudentsNotifier(ref),
);

class StudentsNotifier extends StateNotifier<List<Student>> {
  final Ref ref;
  final Map<int, String> keyMap = {};
  
  StudentsNotifier(this.ref) : super([]) {
    loadStudents();
  }

  Future<void> loadStudents() async {
    try {
      final students = await fetchStudentsFromDatabase();
      state = students;
    } catch (e) {
      print('Error loading students: $e');
    }
  }
 
  Future<void> deleteStudentByLastName(String lastName) async {
  try {
    final url = Uri.parse('https://students-8a3ec-default-rtdb.firebaseio.com/students.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String? keyToDelete;

      data.forEach((key, value) {
        if (value['lastName'] == lastName) {
          keyToDelete = key;
        }
      });

      if (keyToDelete != null) {
        await deleteStudentFromDatabase(keyToDelete!);
        await loadStudents();
        print('Student with last name $lastName deleted');
      } else {
        throw Exception('Student not found');
      }
    } else {
      throw Exception('Failed to fetch students');
    }
  } catch (e) {
    print('Error deleting student by last name: $e');
  }
}

 Future<void> updateStudentByLastName(String lastName, Student updatedStudent) async {
  try {
    final url = Uri.parse('https://students-8a3ec-default-rtdb.firebaseio.com/students.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String? keyToUpdate;

      data.forEach((key, value) {
        if (value['lastName'] == lastName) {
          keyToUpdate = key;
        }
      });

      if (keyToUpdate != null) {
        await updateStudentInDatabase(keyToUpdate!, updatedStudent);
        await loadStudents();

        print('Student with last name $lastName updated');
      } else {
        throw Exception('Student not found');
      }
    } else {
      throw Exception('Failed to fetch students');
    }
  } catch (e) {
    print('Error updating student by last name: $e');
  }
}

  void removeStudentLocal(Student student) {
    final updatedList = List<Student>.from(state);
    updatedList.removeWhere((item) => item.lastName == student.lastName);
    state = updatedList;
  }

  void insertStudentLocal(Student student) {
    final updatedList = List<Student>.from(state);
    updatedList.add(student);
    state = updatedList;
  }
  
  void addStudent(Student student) async {
    state = [...state, student];
    await addStudentToDatabase(student);
  }
}
