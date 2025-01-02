import 'package:flutter/material.dart';
import '../widgets/department_item.dart';
import '../models/department.dart';

class Departments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Departments')),
      body: GridView.builder(
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