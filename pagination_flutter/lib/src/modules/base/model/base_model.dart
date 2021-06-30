abstract class BaseValue {
  fromJSON(Map<String, dynamic> json) {}

  toJSON() {}
}

class BaseModel<T extends BaseValue> {
  BaseModel({
    this.confirm,
    this.message,
    this.modelStateErrors,
    this.success,
    this.value,
  });

  final bool confirm;
  final dynamic message;
  final List<dynamic> modelStateErrors;
  final bool success;
  final T value;

  factory BaseModel.fromJson(Map<String, dynamic> json, BaseValue value) => BaseModel(
    confirm: json["confirm"] == null ? null : json["confirm"],
    message: json["message"],
    modelStateErrors: json["modelStateErrors"] == null ? null : List<dynamic>.from(json["modelStateErrors"].map((x) => x)),
    success: json["success"] == null ? null : json["success"],
    value: json["value"] == null ? null : value,
  );

  Map<String, dynamic> toJson() => {
    "confirm": confirm == null ? null : confirm,
    "message": message,
    "modelStateErrors": modelStateErrors == null ? null : List<dynamic>.from(modelStateErrors.map((x) => x)),
    "success": success == null ? null : success,
    "value": value == null ? null : value.toJSON(),
  };
}