


class EmailsModel {
  final String subject;
  final String sender;
  final String body;
  EmailsModel({this.subject, this.sender, this.body});

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "organizer": sender,
    "duration": body
  };
  factory EmailsModel.fromJson(Map<dynamic, dynamic> json) => EmailsModel(
      subject: json["subject"],
      sender: json["sender"],
      body: json["body"]
  );
}