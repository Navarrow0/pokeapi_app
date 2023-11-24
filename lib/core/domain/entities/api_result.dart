class ApiResult<T> {
  final T? data;
  final String? errorMessage;

  ApiResult({this.data, this.errorMessage});
}
