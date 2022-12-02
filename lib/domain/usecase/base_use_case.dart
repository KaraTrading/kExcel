abstract class UseCase<T, P> {
  T call(P params);
}

abstract class BaseUseCase<Type, Params>
    extends UseCase<Future<Type?>, Params> {
  @override
  Future<Type?> call(Params params);
}

abstract class BaseUseCaseSync<Type, Params> extends UseCase<Type?, Params> {
  @override
  Type? call(Params params);
}
