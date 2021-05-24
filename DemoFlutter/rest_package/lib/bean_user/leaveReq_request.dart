import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'leaveReq_request.g.dart';

@JsonSerializable()
class LeaveRequest extends BaseRequest {
  String employeeNo;
  String firstname;
  String lastname;
  List<DateTime> leaveDate;
  String leaveType;
  String amount;

  LeaveRequest(this.employeeNo, this.firstname, this.lastname, this.leaveDate,this.leaveType,
      this.amount,String reqRefNo) : super(reqRefNo);
  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveRequestToJson(this);
}
