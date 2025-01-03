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

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['firstName'],
      lastName: json['lastName'],
      department: _parseDepartment(json['department']),
      grade: json['grade'],
      gender: _parseGender(json['gender']),
    );
  }

  static dept.DepartmentType _parseDepartment(String department) {
    const departmentMap = {
      'dept.departmenttype.it': dept.DepartmentType.it,
      'dept.departmenttype.medical': dept.DepartmentType.medical,
      'dept.departmenttype.law': dept.DepartmentType.law,
      'dept.departmenttype.finance': dept.DepartmentType.finance,
    };

    return departmentMap[department.toLowerCase()] ?? dept.DepartmentType.it;
  }

  static Gender _parseGender(String gender) {
    if (gender.toLowerCase() == 'gender.male') {
      return Gender.male;
    } else if (gender.toLowerCase() == 'gender.female') {
      return Gender.female;
    } else {
      return Gender.female;
    }
  }

  @override
  String toString() {
    return '$firstName $lastName, Department: $department, Grade: $grade, Gender: $gender';
  }
}
