import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean_user/base_request.dart';
part 'config_request.g.dart';

@JsonSerializable()
class ConfigRequest extends BaseRequest{
  String scoreFaceCompare;
  String timeAttendanceStart;
  String timeAttendanceBeforeLate;
  String timeAttendanceEnd;
  String vacationDays;
  String casualDays;
  String sickDays;
  String customerNo;
  String nameEn;
  String position;

  ConfigRequest(this.scoreFaceCompare,this.timeAttendanceStart,this.timeAttendanceBeforeLate,this.timeAttendanceEnd,this.vacationDays,
      this.casualDays,this.sickDays,this.customerNo,this.nameEn,this.position,String reqRefNo) : super(reqRefNo);
  factory ConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfigRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigRequestToJson(this);
}