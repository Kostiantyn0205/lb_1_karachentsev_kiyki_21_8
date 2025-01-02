import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../widgets/student_item.dart';
import '../widgets/new_student.dart';
import '../providers/students_provider.dart'; // Путь к провайдеру

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

  void _editStudent(BuildContext context, WidgetRef ref, int index, Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          student: student,
          onSave: (updatedStudent) {
            ref.read(studentsProvider.notifier).updateStudent(index, updatedStudent);
          },
        );
      },
    );
  }

  void _deleteStudent(BuildContext context, WidgetRef ref, int index) {
    final deletedStudent = ref.read(studentsProvider)[index];

    ref.read(studentsProvider.notifier).deleteStudent(index);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedStudent.firstName} ${deletedStudent.lastName} deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref.read(studentsProvider.notifier).insertStudent(index, deletedStudent);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
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
            onTap: () => _editStudent(context, ref, index, student),
            child: Dismissible(
              key: Key(student.firstName + student.lastName),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteStudent(context, ref, index);
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
