import 'dart:convert';

class Passcode {
  String code;
  bool isActive;

  @override
  String toString() {
    var data = {
      "code": code,
      "isActive": isActive
    };

    return jsonEncode(data);
  }
}