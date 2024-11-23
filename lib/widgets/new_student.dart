import 'package:flutter/material.dart';
import '../models/student.dart';

class NewStudent extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const NewStudent({Key? key, this.student, required this.onSave}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Department? _selectedDepartment;
  Gender? _selectedGender;
  final _gradeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
      _gradeController.text = widget.student!.grade.toString();
    }
  }

  void _saveStudent() {
    final updatedStudent = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      department: _selectedDepartment ?? Department.it,
      grade: int.parse(_gradeController.text),
      gender: _selectedGender ?? Gender.male,
    );
    widget.onSave(updatedStudent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          DropdownButton<Department>(
            value: _selectedDepartment,
            hint: const Text('Select Department'),
            onChanged: (newValue) {
              setState(() {
                _selectedDepartment = newValue;
              });
            },
            items: Department.values.map((department) {
              return DropdownMenuItem<Department>(
                value: department,
                child: Text(department.toString().split('.').last),
              );
            }).toList(),
          ),
          DropdownButton<Gender>(
            value: _selectedGender,
            hint: const Text('Select Gender'),
            onChanged: (newValue) {
              setState(() {
                _selectedGender = newValue;
              });
            },
            items: Gender.values.map((gender) {
              return DropdownMenuItem<Gender>(
                value: gender,
                child: Text(gender.toString().split('.').last),
              );
            }).toList(),
          ),
          TextField(
            controller: _gradeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Grade'),
          ),
          ElevatedButton(
            onPressed: _saveStudent,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
