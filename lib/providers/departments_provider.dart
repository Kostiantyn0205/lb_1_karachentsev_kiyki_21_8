import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart' as dept;
import '../providers/students_provider.dart';

final departmentsProvider = Provider<List<dept.Department>>((ref) {
  final students = ref.watch(studentsProvider); // Получаем список студентов через studentsProvider
  final baseDepartments = dept.departments.values.toList(); // Берем все факультеты из базы данных

  return baseDepartments.map((department) {
    // Подсчитываем количество студентов для каждого факультета, сравнивая типы
    final enrolledCount = students.where((student) { return student.department == department.type;}).length;
    return department.copyWith(enrolledStudents: enrolledCount); // Возвращаем факультет с количеством студентов
  }).toList();
});