import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/department.dart' as dept;

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
  dept.DepartmentType? _selectedDepartment;
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
  if (_firstNameController.text.isEmpty ||
      _lastNameController.text.isEmpty ||
      _selectedDepartment == null ||
      _selectedGender == null ||
      _gradeController.text.isEmpty) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Colors.red, 
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
            ),
          ),
          content: const Text(
            'Please fill in all fields',
            style: TextStyle(color: Colors.black), 
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('ОК', style: TextStyle(color: Colors.black)), 
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), 
            side: const BorderSide(color: Colors.red, width: 2), 
          ),
        );
      },
    );
    return; 
  }


    final updatedStudent = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      department: _selectedDepartment ?? dept.DepartmentType.it,
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
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          DropdownButton<dept.DepartmentType>(
            value: _selectedDepartment,
            hint: const Text('Select Department'),
            onChanged: (newValue) {
              setState(() {
                _selectedDepartment = newValue;
              });
            },
            items: dept.DepartmentType.values.map((department) {
              return DropdownMenuItem<dept.DepartmentType>(
                value: department,
                child: Row(
                  children: [
                    Icon(dept.departmentIcons[department], color: const Color.fromARGB(255, 0, 0, 0)),
                    const SizedBox(width: 8),
                    Text(department.toString().split('.').last),
                  ],
                ),
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
            style: Theme.of(context).textTheme.bodyMedium,
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
