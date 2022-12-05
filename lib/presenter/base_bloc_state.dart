abstract class BaseBlocState {}

class InitState extends BaseBlocState {
  final dynamic value;

  InitState({this.value});
}

class LoadingState extends BaseBlocState {}

class ResponseState<T> extends BaseBlocState {
  final T data;

  ResponseState({required this.data});
}

class ErrorState extends BaseBlocState {
  final dynamic error;

  ErrorState({this.error});
}

extension ResponseStateExtensions on ResponseState {
  bool get noData {
    if (data == null) {
      return true;
    }
    if (data is List && (data as List).isEmpty) {
      return true;
    }
    return false;
  }
}
