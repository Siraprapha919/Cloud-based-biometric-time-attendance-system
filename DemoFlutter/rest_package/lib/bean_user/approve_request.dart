import 'base_request.dart';

class ApproveRequest extends BaseRequest{
  String employeeNo;
  String firstname;
  String lastname;
  List<String> leaveDate;
  String amount;

  ApproveRequest(String reqRefNo) : super(reqRefNo);

}