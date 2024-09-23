abstract class DataState<T> {
  final T data;
  final int? statusCode;
  final String? message;
  const DataState({required this.data, this.statusCode, this.message});
}

class DataSuccess<R> extends DataState<R> {
  const DataSuccess(R data) : super(data: data);
}

class DataFailed<F> extends DataState<F> {
  const DataFailed(F error, int? statusCode, String? message) : super(data: error, message: message, statusCode: statusCode);
}
