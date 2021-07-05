
import 'value_failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const String explanation =
        "A ValueFailure occurred. Terminating.";
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
  