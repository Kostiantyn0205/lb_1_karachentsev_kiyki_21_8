import './department.dart' as dept;

enum Gender { male, female }

class Student {
  final String firstName;
  final String lastName;
  final dept.DepartmentType department;
  final int grade;
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });

  @override
  String toString() {
    return '$firstName $lastName, Department: $department, Grade: $grade, Gender: $gender';
  }
}
