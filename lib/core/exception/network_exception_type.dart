enum BaseNetworkExceptionType {
  /// send or receiving timeout.
  timeout,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  /// When the request is cancelled.
  cancel,

  /// Default error type, Some other Error. In this case, you can
  /// use the error if it is not null.
  other,
}
