import 'package:flutter/material.dart';
import '../widgets/department_item.dart';
import '../models/department.dart';

class Departments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Departments')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,  // Количество колонок
          crossAxisSpacing: 8,  // Отступы между колонками
          mainAxisSpacing: 8,  // Отступы между строками
          childAspectRatio: 200 / 140, // Соотношение ширины к высоте карточки
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