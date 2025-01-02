import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart'; // Импортируем единственное определение Student
import '../models/department.dart' as dept;

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
  (ref) => StudentsNotifier(),
);

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier()
      : super([
          Student(
            firstName: 'Alex',
            lastName: 'Johnson',
            department: dept.DepartmentType.it,
            grade: 5,
            gender: Gender.male,
          ),
          Student(
            firstName: 'Ethan',
            lastName: 'Brown',
            department: dept.DepartmentType.medical,
            grade: 3,
            gender: Gender.male,
          ),
          Student(
            firstName: 'Emma',
            lastName: 'Davis',
            department: dept.DepartmentType.law,
            grade: 4,
            gender: Gender.female,
          ),
          Student(
            firstName: 'Liam',
            lastName: 'Garcia',
            department: dept.DepartmentType.finance,
            grade: 5,
            gender: Gender.male,
          ),
          Student(
            firstName: 'Olivia',
            lastName: 'Martinez',
            department: dept.DepartmentType.medical,
            grade: 5,
            gender: Gender.female,
          ),
          Student(
            firstName: 'Lucas',
            lastName: 'Miller',
            department: dept.DepartmentType.it,
            grade: 4,
            gender: Gender.male,
          ),
          Student(
            firstName: 'Mia',
            lastName: 'Hernandez',
            department: dept.DepartmentType.law,
            grade: 5,
            gender: Gender.female,
          ),
          Student(
            firstName: 'Amelia',
            lastName: 'Clark',
            department: dept.DepartmentType.it,
            grade: 4,
            gender: Gender.female,
          ),
        ]);

  // Додавання студента
  void addStudent(Student student) {
    state = [...state, student];
  }

  // Оновлення студента
  void updateStudent(int index, Student updatedStudent) {
    final updatedList = List<Student>.from(state);
    updatedList[index] = updatedStudent;
    state = updatedList;
  }

  // Видалення студента
  void deleteStudent(int index) {
    final updatedList = List<Student>.from(state);
    updatedList.removeAt(index);
    state = updatedList;
  }

  // Вставка студента по індексу
  void insertStudent(int index, Student student) {
    final updatedList = List<Student>.from(state);
    updatedList.insert(index, student);
    state = updatedList;
  }
}
