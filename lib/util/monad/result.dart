class Result<T> {
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
}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value);
}

class Failure<T> extends Result<T> {
  final Exception error;

  Failure(this.error);
}
