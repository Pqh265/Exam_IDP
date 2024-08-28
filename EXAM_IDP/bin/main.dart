
import 'dart:io';
import '../lib/services/student_service.dart';
import '../lib/models/student.dart';

void main() async {
  final studentService = StudentService('data/Student.json');

  while (true) {
    print('----- Quản lý sinh viên -----');
    print('1. Hiển thị toàn bộ sinh viên');
    print('2. Thêm sinh viên');
    print('3. Sửa thông tin sinh viên');
    print('4. Tìm kiếm sinh viên');
    print('5. Thoát');
    stdout.write('Chọn chức năng: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        List<Student> students = await studentService.loadStudents();
        for (var student in students) {
          print('ID: ${student.id}, Tên: ${student.name}, Môn học: ${student.subjects.map((s) => '${s.subjectName} (${s.score})').join(', ')}');
        }
        break;

      case '2':
        stdout.write('Nhập ID sinh viên: ');
        String id = stdin.readLineSync()!;
        stdout.write('Nhập tên sinh viên: ');
        String name = stdin.readLineSync()!;
        List<Subject> subjects = [];

        while (true) {
          stdout.write('Nhập môn học (hoặc gõ "x" để dừng): ');
          String subjectName = stdin.readLineSync()!;
          if (subjectName.toLowerCase() == 'x') break;
          stdout.write('Nhập điểm: ');
          double score = double.parse(stdin.readLineSync()!);
          subjects.add(Subject(subjectName: subjectName, score: score));
        }

        await studentService.addStudent(Student(id: id, name: name, subjects: subjects));
        print('Đã thêm sinh viên thành công!');
        break;

      case '3':
        stdout.write('Nhập ID sinh viên để sửa: ');
        String idToUpdate = stdin.readLineSync()!;
        Student? studentToUpdate = await studentService.findStudentById(idToUpdate);
        if (studentToUpdate != null) {
          stdout.write('Nhập tên mới (hiện tại: ${studentToUpdate.name}): ');
          String newName = stdin.readLineSync()!;
          List<Subject> updatedSubjects = [];

          while (true) {
            stdout.write('Nhập môn học (hoặc gõ "x" để dừng): ');
            String subjectName = stdin.readLineSync()!;
            if (subjectName.toLowerCase() == 'x') break;
            stdout.write('Nhập điểm: ');
            double score = double.parse(stdin.readLineSync()!);
            updatedSubjects.add(Subject(subjectName: subjectName, score: score));
          }

          await studentService.updateStudent(idToUpdate, Student(id: idToUpdate, name: newName, subjects: updatedSubjects));
          print('Đã sửa thông tin sinh viên thành công!');
        } else {
          print('Không tìm thấy sinh viên với ID: $idToUpdate');
        }
        break;

      case '4':
        stdout.write('Nhập tên hoặc ID để tìm kiếm: ');
        String searchQuery = stdin.readLineSync()!;
        List<Student> foundStudents = await studentService.searchStudents(searchQuery);
        if (foundStudents.isNotEmpty) {
          for (var student in foundStudents) {
            print('ID: ${student.id}, Tên: ${student.name}, Môn học: ${student.subjects.map((s) => '${s.subjectName} (${s.score})').join(', ')}');
          }
        } else {
          print('Không tìm thấy sinh viên nào!');
        }
        break;

      case '5':
        exit(0);
      default:
        print('Chọn không hợp lệ. Vui lòng thử lại!');
    }
  }
}
