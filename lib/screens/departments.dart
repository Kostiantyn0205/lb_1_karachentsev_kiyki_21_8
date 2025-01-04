import 'package:flutter/material.dart';
import '../widgets/department_item.dart';
import '../models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';

class Departments extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(studentsProvider.notifier).isLoading;
    ref.watch(studentsProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Departments')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 200 / 140,
              ),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                Department department = departments.values.elementAt(index);
                return DepartmentItem(department: department);
              },
            ),
    );
  }
}