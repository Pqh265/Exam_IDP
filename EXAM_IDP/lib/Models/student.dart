
class Student {
  String id;
  String name;
  List<Subject> subjects;

  Student({required this.id, required this.name, required this.subjects});

  factory Student.fromJson(Map<String, dynamic> json) {
    var subjectList = json['subjects'] as List;
    List<Subject> subjects = subjectList.map((i) => Subject.fromJson(i)).toList();

    return Student(
      id: json['id'],
      name: json['name'],
      subjects: subjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }
}

class Subject {
  String subjectName;
  double score;

  Subject({required this.subjectName, required this.score});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectName: json['subjectName'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'score': score,
    };
  }
}
