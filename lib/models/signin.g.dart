// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signin _$SigninFromJson(Map<String, dynamic> json) {
  return Signin(
    json['SignInSignature'] as String,
    json['CandidateId'] as int,
  );
}

Map<String, dynamic> _$SigninToJson(Signin instance) => <String, dynamic>{
      'SignInSignature': instance.SignInSignature,
      'CandidateId': instance.CandidateId,
    };
