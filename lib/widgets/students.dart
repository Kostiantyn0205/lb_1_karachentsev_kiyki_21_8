import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class Students extends StatelessWidget {
  final List<Student> students = [
    Student(
      firstName: 'Alex',
      lastName: 'Johnson',
      department: Department.it,
      grade: 5,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Ethan',
      lastName: 'Brown',
      department: Department.medical,
      grade: 3,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Emma',
      lastName: 'Davis',
      department: Department.law,
      grade: 4,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Liam',
      lastName: 'Garcia',
      department: Department.finance,
      grade: 5,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Olivia',
      lastName: 'Martinez',
      department: Department.medical,
      grade: 5,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Lucas',
      lastName: 'Miller',
      department: Department.it,
      grade: 4,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Mia',
      lastName: 'Hernandez',
      department: Department.law,
      grade: 5,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Amelia',
      lastName: 'Clark',
      department: Department.it,
      grade: 4,
      gender: Gender.female,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
