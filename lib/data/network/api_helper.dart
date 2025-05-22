import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiHelper {
  static final _requestQueue = StreamController<_QueueItem>();
  static bool _isProcessing = false;

  static void _initializeQueue() {
    if (!_isProcessing) {
      _isProcessing = true;
      _processQueue();
    }
  }

  static void _processQueue() {
    _requestQueue.stream.listen((item) async {
      try {
        final result = await item.operation();
        item.completer.complete(result);
      } catch (e) {
        item.completer.completeError(e);
      }
    });
  }

  /// A common API call method to handle POST requests.
  ///
  /// - [url]: The endpoint to send the request.
  /// - [body]: The request payload (Map<String, dynamic>).
  ///
  /// Returns a `Map<String, dynamic>` containing the JSON response or an error message.
  ///
  static Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    _initializeQueue();

    final completer = Completer<Map<String, dynamic>>();

    _requestQueue.sink.add(_QueueItem(
      operation: () async {
        print(url);
        print('Body:');
        print(body);

        try {
          final response = await http.post(
            Uri.parse(url),
            body: body,
          );
          print('Response:');
          print(response.body);

          if (response.statusCode >= 200 && response.statusCode < 300) {
            return jsonDecode(response.body) as Map<String, dynamic>;
          } else {
            print('Http Error: ${response.statusCode}');
            print(response.body);
            return {
              'error': true,
              'message': 'HTTP Error: ${response.statusCode}',
              'details': response.statusCode == 500
                  ? "Internal Server Error!"
                  : response.body,
            };
          }
        } catch (e) {
          print('Exception:');
          print(e.toString());
          return {
            'error': true,
            'message': 'An exception occurred',
            'details': e.toString(),
          };
        }
      },
      completer: completer,
    ));

    return completer.future;
  }

  /// A common API call method to handle GET requests.
  ///
  /// - [url]: The endpoint to send the request.
  ///
  /// Returns a `Map<String, dynamic>` containing the JSON response or an error message.
  static Future<Map<String, dynamic>> getRequest({
    required String url,
  }) async {
    _initializeQueue();

    final completer = Completer<Map<String, dynamic>>();

    _requestQueue.sink.add(_QueueItem(
      operation: () async {
        print(url);
        try {
          final response = await http.get(
            Uri.parse(url),
          );
          print('Response:');
          print(response.body);

          if (response.statusCode >= 200 && response.statusCode < 300) {
            return jsonDecode(response.body) as Map<String, dynamic>;
          } else {
            print('Http Error:');
            print(response.body);
            return {
              'error': true,
              'message': 'HTTP Error: ${response.statusCode}',
              'details': response.body,
            };
          }
        } catch (e) {
          print('Exception:');
          print(e.toString());
          return {
            'error': true,
            'message': 'An exception occurred',
            'details': e.toString(),
          };
        }
      },
      completer: completer,
    ));

    return completer.future;
  }

  static void dispose() {
    _requestQueue.close();
    _isProcessing = false;
  }
}

class _QueueItem {
  final Future<Map<String, dynamic>> Function() operation;
  final Completer<Map<String, dynamic>> completer;

  _QueueItem({
    required this.operation,
    required this.completer,
  });
}
