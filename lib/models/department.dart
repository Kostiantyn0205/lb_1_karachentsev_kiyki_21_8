import 'package:flutter/material.dart';

enum DepartmentType { finance, law, it, medical }

// Модель факультета, где color теперь является LinearGradient
class Department {
  final String name;
  final LinearGradient color;  // изменили тип на LinearGradient
  final IconData icon;
  final String id;
  final DepartmentType type;
  final int enrolledStudents;

  Department({
    required this.name,
    required this.color,
    required this.icon,
    required this.id,
    required this.type,
    this.enrolledStudents = 0,
  });

 @override
  String toString() {
    return 'Department(name: $name, students: $enrolledStudents)';
  }

  Department copyWith({int? enrolledStudents}) {
    return Department(
      name: name,
      color: color,
      icon: icon,
      id: id,
      type: type,
      enrolledStudents: enrolledStudents ?? this.enrolledStudents, // Если не передано, то берем старое значение
    );
  }
}

// Список факультетов с градиентами
final Map<DepartmentType, Department> departments = {
  DepartmentType.law: Department(
    name: 'Law',
    color: LinearGradient(  // создаем градиент для факультета law
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromARGB(255, 8, 69, 152), const Color.fromARGB(155, 6, 96, 175)],  // Пара цветов для градиента 
    ),
    icon: Icons.balance,
    id: '1',
    type: DepartmentType.law,
  ),
  DepartmentType.it: Department(
    name: 'IT',
    color: LinearGradient(  // создаем градиент для факультета IT
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromARGB(255, 8, 102, 121), const Color.fromARGB(155, 5, 145, 174)],  // Пара цветов для градиента
    ),
    icon: Icons.developer_mode,
    id: '2',
    type: DepartmentType.it,
  ),
  DepartmentType.medical: Department(
    name: 'Medical',
    color: LinearGradient(  // создаем градиент для факультета medical
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromARGB(255, 66, 11, 120), const Color.fromARGB(155, 94, 6, 173)],  // Пара цветов для градиента
    ),
    icon: Icons.health_and_safety,
    id: '3',
    type: DepartmentType.medical,
  ),
  DepartmentType.finance: Department(
    name: 'Finance',
    color: LinearGradient(  // создаем градиент для факультета Finance
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [const Color.fromARGB(255, 108, 11, 122), const Color.fromARGB(155, 160, 6, 175)],  // Пара цветов для градиента
    ),
    icon: Icons.account_balance,
    id: '4',
    type: DepartmentType.finance,
  ),
};