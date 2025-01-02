import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart' as dept;
import '../providers/students_provider.dart';

final departmentsProvider = Provider<List<dept.Department>>((ref) {
  final students = ref.watch(studentsProvider);
  final baseDepartments = dept.departments.values.toList();

  return baseDepartments.map((department) {
    final enrolledCount = students.where((student) { return student.department == department.type;}).length;
    return department.copyWith(enrolledStudents: enrolledCount);
  }).toList();
});