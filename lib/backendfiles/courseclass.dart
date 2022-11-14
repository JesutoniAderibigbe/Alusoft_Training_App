class Course {
  int ID;
  String NAME;
  String DESCRIPTION;
  int DURATION;
  int INSTRUCTOR_ID;

  Course(
      {required this.ID,
      required this.NAME,
      required this.DESCRIPTION,
      required this.DURATION,
      required this.INSTRUCTOR_ID});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      ID: json['ID'],
      NAME: json['NAME'],
      DESCRIPTION: json['DESCRIPTION'],
      DURATION: json['DURATION'],
      INSTRUCTOR_ID: json['INSTRUCTOR_ID'],
    );
  }
}
