class ExceptionHandlerResponse<T> {
  final String? error;
  final T? result;

  ExceptionHandlerResponse({this.error, this.result});
}
