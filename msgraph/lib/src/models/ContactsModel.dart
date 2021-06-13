


class ContactsModel {
  final String contactName;
  final String mobile;
  ContactsModel({this.contactName, this.mobile});

  Map<String, dynamic> toJson() => {
    "contactName": contactName,
    "mobile": mobile,
  };
  factory ContactsModel.fromJson(Map<dynamic, dynamic> json) => ContactsModel(
      contactName: json["contactName"],
      mobile: json["mobile"],
  );
}