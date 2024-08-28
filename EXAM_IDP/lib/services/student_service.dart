
import 'dart:convert';
import 'dart:io';
import '../models/student.dart';

class StudentService {
  final String filePath;

  StudentService(this.filePath);

  Future<List<Student>> loadStudents() async {
    final file = File(filePath);
    String jsonString = await file.readAsString();
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((student) => Student.fromJson(student)).toList();
  }

  Future<void> addStudent(Student student) async {
    List<Student> students = await loadStudents();
    students.add(student);
    await saveStudents(students);
  }

  Future<void> updateStudent(String id, Student updatedStudent) async {
    List<Student> students = await loadStudents();
    int index = students.indexWhere((student) => student.id == id);
    if (index != -1) {
      students[index] = updatedStudent;
      await saveStudents(students);
    }
  }

  Future<void> saveStudents(List<Student> students) async {
    final file = File(filePath);
    String jsonString = json.encode(students.map((student) => student.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<Student?> findStudentById(String id) async {
    List<Student> students = await loadStudents();
    return students.firstWhere((student) => student.id == id, orElse: () => null);
  }

  Future<List<Student>> searchStudents(String nameOrId) async {
    List<Student> students = await loadStudents();
    return students.where((student) => student.name.contains(nameOrId) || student.id == nameOrId).toList();
  }
}
