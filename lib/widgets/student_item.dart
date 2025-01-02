import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: student.gender == Gender.male ? Colors.indigo : Colors.purpleAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${student.firstName} ${student.lastName}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            children: [
              Icon(departmentIcons[student.department], color: Colors.white),
              const SizedBox(width: 8),
              Text(
                student.grade.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
