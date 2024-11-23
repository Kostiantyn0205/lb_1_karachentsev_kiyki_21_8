import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';
import 'new_student.dart';

class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final List<Student> _students = [
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

  Student? _lastDeletedStudent;
  int? _lastDeletedIndex;

  void _addNewStudent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          onSave: (newStudent) {
            setState(() {
              _students.add(newStudent);
            });
          },
        );
      },
    );
  }

   void _editStudent(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          student: _students[index],
          onSave: (updatedStudent) {
            setState(() {
              _students[index] = updatedStudent;
            });
          },
        );
      },
    );
  }

  void _deleteStudent(int index) {
    final deletedStudent = _students[index];
    _lastDeletedStudent = deletedStudent;
    _lastDeletedIndex = index;

    setState(() {
      _students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedStudent.firstName} ${deletedStudent.lastName} deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            _undoDelete();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _undoDelete() {
    if (_lastDeletedStudent != null && _lastDeletedIndex != null) {
      setState(() {
        _students.insert(_lastDeletedIndex!, _lastDeletedStudent!);
      });
      _lastDeletedStudent = null;
      _lastDeletedIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewStudent,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _editStudent(index);
            },
            child: Dismissible(
              key: Key(_students[index].firstName + _students[index].lastName),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteStudent(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              child: StudentItem(student: _students[index]),
            ),
          );
        },
      ),
    );
  }
}
