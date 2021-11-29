import 'package:common/res.dart';

abstract class HttpException implements Exception {
  final String requestUrl;

  final Map<String, String> requestBody;

  HttpException(this.requestUrl, this.requestBody);

  String get userMessage;

  Map<String, String> get extras => {
        'url': requestUrl,
        'requestBody': requestBody.toString(),
      };
}

class HttpClientException extends HttpException {
  final String debugInfo;

  HttpClientException(
    String requestUrl,
    Map<String, String> requestBody,
    this.debugInfo,
  ) : super(requestUrl, requestBody);

  @override
  String get userMessage => HCommonStrings.httpErrorClient;

  @override
  Map<String, String> get extras => {
        ...super.extras,
        'debugInfo': debugInfo,
      };

  @override
  String toString() {
    return 'HttpClientException{requestUrl:$requestUrl debugInfo: $debugInfo}';
  }
}

class HttpNoInternetException extends HttpClientException {
  HttpNoInternetException(
    String requestUrl,
    Map<String, String> requestBody,
    String debugInfo,
  ) : super(requestUrl, requestBody, debugInfo);

  @override
  String get userMessage => HCommonStrings.httpErrorNoInternet;
}

abstract class HttpResponseException extends HttpException {
  final int responseCode;

  final String responseMessage;

  final String responseBody;

  HttpResponseException(
    String requestUrl,
    Map<String, String> requestBody,
    this.responseCode,
    this.responseMessage,
    this.responseBody,
  ) : super(requestUrl, requestBody);

  @override
  Map<String, String> get extras => {
        ...super.extras,
        'responseCode': responseCode.toString(),
        'responseMessage': responseMessage,
        'responseBody': responseBody,
      };

  @override
  String toString() {
    return 'HttpResponseException{'
        'requestUrl:$requestUrl '
        'responseCode: $responseCode '
        'responseMessage: $responseMessage '
        'responseBody: $responseBody '
        '}';
  }
}

class HttpJsonDecodeException extends HttpResponseException {
  HttpJsonDecodeException(
    String requestUrl,
    Map<String, String> requestBody,
    int responseCode,
    String responseMessage,
    String responseBody,
  ) : super(requestUrl, requestBody, responseCode, responseMessage,
            responseBody);

  @override
  String get userMessage => HCommonStrings.httpErrorJsonDecode;
}

class HHttpApiError extends HttpResponseException {
  static const typeValidation = 'validation_error';

  static const _errorCodeKey = 'error_code';

  static const _messageKey = 'message';

  static const _typeKey = 'type';

  static const _errorsKey = 'errors';

  static bool hasErrors(Map<String, dynamic> responseJson) {
    return responseJson[_messageKey] != null ||
        responseJson[_errorsKey] != null;
  }

  final Map<String, dynamic> parsedResponse;

  HHttpApiError(
    String requestUrl,
    Map<String, String> requestBody,
    int responseCode,
    String responseMessage,
    String responseBody,
    this.parsedResponse,
  ) : super(requestUrl, requestBody, responseCode, responseMessage,
            responseBody);

  int get apiErrorCode => parsedResponse[_errorCodeKey] as int;

  String? get apiMessage => parsedResponse[_messageKey] as String?;

  String get apiType => parsedResponse[_typeKey] as String;

  dynamic get apiErrors => parsedResponse[_errorsKey];

  @override
  String get userMessage {
    final message = apiMessage;
    if (message != null) {
      return message;
    }
    final dynamic errors = apiErrors;
    if (errors != null) {
      if (errors is List) {
        return errors.join(', ');
      } else {
        return errors.toString();
      }
    }
    assert(false);
    return HCommonStrings.httpErrorUnknown;
  }
}
