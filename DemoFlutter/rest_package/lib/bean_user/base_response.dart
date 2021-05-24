abstract class BaseResponse {

  final String respCode;
  final String respDesc;
  final String reqRefNo;
  final String respRefNo;

  BaseResponse(this.respCode, this.respDesc, this.reqRefNo, this.respRefNo);
}