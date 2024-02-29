class ExceptionHandlerResponseModel<T> {
  final String? error;
  final T? result;

  ExceptionHandlerResponseModel({this.error, this.result});
  bool get isError => error != null;
}
