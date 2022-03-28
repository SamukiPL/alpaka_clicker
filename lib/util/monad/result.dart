class Result<T> {
  Result._();

  bool isSuccess() => this is Success<T>;

  bool isFailure() => this is Failure<T>;

  Result<T> onSuccess(Function(T value) block) {
    if (this is Success<T>) {
      block((this as Success<T>).value);
    }
    return this;
  }

  Result<T> onFailure(Function(Exception exception) block) {
    if (this is Failure<T>) {
      block((this as Failure<T>).error);
    }
    return this;
  }

  factory Result.success(T value) = Success;
  factory Result.failure(Exception exception) = Failure;
}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value): super._();
}

class Failure<T> extends Result<T> {
  final Exception error;

  Failure(this.error): super._();
}
