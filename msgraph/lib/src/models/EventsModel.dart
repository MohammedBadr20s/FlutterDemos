




class EventsModel {
  final String subject;
  final String organizer;
  final String duration;
  EventsModel({this.subject, this.organizer, this.duration});

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "organizer": organizer,
    "duration": duration
  };
  factory EventsModel.fromJson(Map<dynamic, dynamic> json) => EventsModel(
    subject: json["subject"],
    organizer: json["organizer"],
    duration: json["duration"]
  );
}