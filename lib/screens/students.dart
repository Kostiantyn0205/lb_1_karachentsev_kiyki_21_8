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
          onSave: (newStudent) async {
            try {
              await ref.read(studentsProvider.notifier).addStudent(newStudent);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error adding student: $e')),
              );
            }
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
        content: Text('${student.firstName} ${student.lastName} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            studentsNotifier.insertStudentLocal(student);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    ).closed.then((value) async {
      if (value != SnackBarClosedReason.action) {
        try {
          await studentsNotifier.deleteStudentByLastName(student.lastName);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The student has been removed from the database.')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting student: $e')),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final isLoading = ref.watch(studentsProvider.notifier).isLoading;

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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