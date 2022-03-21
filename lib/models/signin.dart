import 'package:json_annotation/json_annotation.dart';
part 'signin.g.dart';

@JsonSerializable()
class Signin {
  final String SignInSignature;
  final int CandidateId;

  Signin(this.SignInSignature, this.CandidateId);

  factory Signin.fromJson(Map<String, dynamic> json) => _$SigninFromJson(json);

  Map<String, dynamic> toJson() => _$SigninToJson(this);
}
