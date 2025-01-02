import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart' as dept; // Псевдоним для импортирования Department
import '../providers/departments_provider.dart'; // Провайдер студентов

class DepartmentItem extends ConsumerWidget {
  final dept.Department department;  // Используем псевдоним dept

  const DepartmentItem({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final departments = ref.watch(departmentsProvider);

      final enrolledStudents = departments
      .firstWhere((dept) => dept.type == department.type)
      .enrolledStudents;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: department.color,  // Используем department из dept
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  department.name,  // Используем department из dept
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Students enrolled: $enrolledStudents',  // Динамическое количество студентов
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(department.icon, size: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}