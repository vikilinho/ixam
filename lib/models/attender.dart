// To parse this JSON data, do
//
//     final attendantCard = attendantCardFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AttendantCard attendantCardFromJson(String str) => AttendantCard.fromJson(json.decode(str));

String attendantCardToJson(AttendantCard data) => json.encode(data.toJson());

class AttendantCard {
  AttendantCard({
    required this.error,
    required this.response,
    required this.message,
  });

  bool error;
  Response response;
  String message;

  factory AttendantCard.fromJson(Map<String, dynamic> json) => AttendantCard(
    error: json["error"],
    response: Response.fromJson(json["response"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "response": response.toJson(),
    "message": message,
  };
}

class Response {
  Response({
    required this.candidateId,
    required this.userId,
    required this.examNo,
    required this.serialNo,
    required this.qrCodeUrl,
    required this.signatureUrl,
    required this.passportUrl,
    required this.attendance,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.updatedAt,
  });

  int candidateId;
  int userId;
  String examNo;
  String serialNo;
  String qrCodeUrl;
  dynamic signatureUrl;
  String passportUrl;
  Attendance attendance;
  String firstName;
  String lastName;
  String middleName;
  DateTime updatedAt;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    candidateId: json["candidateId"],
    userId: json["userId"],
    examNo: json["examNo"],
    serialNo: json["serialNo"],
    qrCodeUrl: json["qrCodeURL"],
    signatureUrl: json["signatureURL"]?? "https://www.mymailhouse.net/images/Email_Tiles-02.png",
    passportUrl: json["passportURL"]?? "",
    attendance: Attendance.fromJson(json["attendance"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    middleName: json["middleName"]?? "",
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "candidateId": candidateId,
    "userId": userId,
    "examNo": examNo,
    "serialNo": serialNo,
    "qrCodeURL": qrCodeUrl,
    "signatureURL": signatureUrl,
    "passportURL": passportUrl,
    "attendance": attendance.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "middleName": middleName,
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Attendance {
  Attendance({
    required this.attendanceId,
    required this.signIn,
    required this.signInSignatureUrl,
    required this.signOut,
    required this.signOutSignatureUrl,
    required this.candidateId,
    required this.createdAt,
    required this.updatedAt,
    required this.candidate,
  });

  int attendanceId;
  DateTime signIn;
  dynamic signInSignatureUrl;
  DateTime signOut;
  dynamic signOutSignatureUrl;
  int candidateId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic candidate;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    attendanceId: json["attendanceId"],
    signIn: DateTime.parse(json["signIn"]),
    signInSignatureUrl: json["signInSignatureURL"],
    signOut: DateTime.parse(json["signOut"]),
    signOutSignatureUrl: json["signOutSignatureURL"],
    candidateId: json["candidateId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    candidate: json["candidate"],
  );

  Map<String, dynamic> toJson() => {
    "attendanceId": attendanceId,
    "signIn": signIn.toIso8601String(),
    "signInSignatureURL": signInSignatureUrl,
    "signOut": signOut.toIso8601String(),
    "signOutSignatureURL": signOutSignatureUrl,
    "candidateId": candidateId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "candidate": candidate,
  };
}
