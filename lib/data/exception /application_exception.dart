class ApplicationException implements Exception {
  String? message;
  String? prefix;

  ApplicationException([this.message, this.prefix]);

  @override
  String toString() {
    return '$message $prefix';
  }
}

class NoInternetConnection  extends ApplicationException{
  NoInternetConnection ([String? message]):super(message ,'No Internet Connection');
}
class TimeOutException  extends ApplicationException{
  TimeOutException ([String? message]):super(message ,'Time Out,Try again later');
}
