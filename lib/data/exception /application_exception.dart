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
}