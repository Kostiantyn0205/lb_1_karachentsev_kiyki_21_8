import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../widgets/student_item.dart';
import '../widgets/new_student.dart';
import '../providers/students_provider.dart';

class Students extends ConsumerWidget {
  const Students({Key? key}) : super(key: key);

  void _addNewStudent(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          onSave: (newStudent) {
            ref.read(studentsProvider.notifier).addStudent(newStudent);
          },
        );
      },
    );
  }

void _editStudent(BuildContext context, WidgetRef ref, Student student) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return NewStudent(
        student: student,
        onSave: (updatedStudent) {
          ref.read(studentsProvider.notifier).updateStudentByLastName(student.lastName, updatedStudent);
        },
      );
    },
  );
}

 void _deleteStudent(BuildContext context, WidgetRef ref, Student student) {
  final studentsNotifier = ref.read(studentsProvider.notifier);

  studentsNotifier.removeStudentLocal(student);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${student.firstName} ${student.lastName} deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          studentsNotifier.insertStudentLocal(student);
        },
      ),
      duration: const Duration(seconds: 5),
    ),
  ).closed.then((value) {
    if (value != SnackBarClosedReason.action) {
      Future.delayed(const Duration(seconds: 5), () {
        studentsNotifier.deleteStudentByLastName(student.lastName);
      });
    }
  });
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addNewStudent(context, ref),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return InkWell(
            onTap: () => _editStudent(context, ref, student),
            child: Dismissible(
              key: Key(student.firstName + student.lastName),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteStudent(context, ref, student);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              child: StudentItem(student: student),
            ),
          );
        },
      ),
    );
  }
}


/*

Student(
            firstName: 'Alex',
            lastName: 'Johnson',
            department: dept.DepartmentType.it,
            grade: 5,
            gender: Gender.male,
            Obj_92456847
          ),
          Student(
            firstName: 'Ethan',
            lastName: 'Brown',
            department: dept.DepartmentType.medical,
            grade: 3,
            gender: Gender.male,
            Obj_84571263
          ),
          Student(
            firstName: 'Emma',
            lastName: 'Davis',
            department: dept.DepartmentType.law,
            grade: 4,
            gender: Gender.female,
            Obj_17293456
          ),
          Student(
            firstName: 'Liam',
            lastName: 'Garcia',
            department: dept.DepartmentType.finance,
            grade: 5,
            gender: Gender.male,
            Obj_53047182
          ),
          Student(
            firstName: 'Olivia',
            lastName: 'Martinez',
            department: dept.DepartmentType.medical,
            grade: 5,
            gender: Gender.female,
            Obj_98376214
          ),
          Student(
            firstName: 'Lucas',
            lastName: 'Miller',
            department: dept.DepartmentType.it,
            grade: 4,
            gender: Gender.male,
            Obj_27163984
          ),
          Student(
            firstName: 'Mia',
            lastName: 'Hernandez',
            department: dept.DepartmentType.law,
            grade: 5,
            gender: Gender.female,
            Obj_83647129
          ),
          Student(
            firstName: 'Amelia',
            lastName: 'Clark',
            department: dept.DepartmentType.it,
            grade: 4,
            gender: Gender.female,
            Obj_49261835
          ),

*/