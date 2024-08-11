//? data state
abstract class DataState<T> {
  final String? error;
  final T? data;

  const DataState(this.error, this.data);
}

//? data success
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(null, data);
}

//? data failed
class DataFailed<T> extends DataState<T> {
  const DataFailed(String? error) : super(error, null);
}
