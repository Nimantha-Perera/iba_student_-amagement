import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  final String batchName; // Define batchName as a final variable

  // Constructor to initialize batchName
  const StudentList({Key? key, required this.batchName}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  // Example list of students (replace this with your actual data)
  List<Student> students = [
    Student(name: 'John Doe', id: '101'),
    Student(name: 'Jane Smith', id: '102'),
    Student(name: 'Michael Brown', id: '103'),
    Student(name: 'Emily Davis', id: '104'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List - ${widget.batchName}"), // Display batchName in the app bar
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          
          
          DataTable(
            columns: [
              DataColumn(label: Text('Student Name')),
              DataColumn(label: Text('Student ID')),
            ],
            rows: students.map((student) {
              return DataRow(
                cells: [
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        // Handle tap on student name (navigate or perform action)
                        _navigateToStudentDetail(student);
                      },
                      child: Text(student.name),
                    ),
                  ),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        // Handle tap on student ID (navigate or perform action)
                        _navigateToStudentDetail(student);
                      },
                      child: Text(student.id),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Method to navigate to student detail screen
  void _navigateToStudentDetail(Student student) {
    // Example navigation logic (replace with your actual navigation code)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(student: student),
      ),
    );
  }
}

// Example class to represent a Student
class Student {
  final String name;
  final String id;

  Student({required this.name, required this.id});
}

// Example student detail screen
class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Student Name: ${student.name}'),
            SizedBox(height: 10),
            Text('Student ID: ${student.id}'),
            // Add more details or actions as needed
          ],
        ),
      ),
    );
  }
}
