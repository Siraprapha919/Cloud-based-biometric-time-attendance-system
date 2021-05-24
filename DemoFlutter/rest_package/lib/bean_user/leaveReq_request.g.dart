// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaveReq_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequest _$LeaveRequestFromJson(Map<String, dynamic> json) {
  return LeaveRequest(
    json['employeeNo'] as String,
    json['firstname'] as String,
    json['lastname'] as String,
    (json['leaveDate'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toList(),
    json['leaveType'] as String,
    json['amount'] as String,
    json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$LeaveRequestToJson(LeaveRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'employeeNo': instance.employeeNo,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'leaveDate':
          instance.leaveDate?.map((e) => e?.toIso8601String())?.toList(),
      'leaveType': instance.leaveType,
      'amount': instance.amount,
    };
