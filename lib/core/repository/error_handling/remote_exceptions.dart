import 'error_code.dart';

class RemoteExceptions implements Exception {
  final ErrorCode errorCode;
  final dynamic errorMsg;

  const RemoteExceptions(this.errorCode, this.errorMsg);

  @override
  String toString() => 'RemoteExceptions(errorMsg: ${errorMsg.toString()})';
}
