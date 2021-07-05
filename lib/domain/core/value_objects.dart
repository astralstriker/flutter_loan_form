import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'error.dart';
import 'value_failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() =>
      value.fold((ValueFailure<T> l) => throw UnexpectedValueError(l), id);

  ValueFailure<T>? get error => value.fold(id, (r) => null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() => UniqueId._(right(Uuid().v1()));

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(right(uniqueId));
  }

  const UniqueId._(this.value);
}

class UniqueIdConvertor implements JsonConverter<UniqueId, String> {
  const UniqueIdConvertor();
  @override
  UniqueId fromJson(String json) => UniqueId.fromUniqueString(json);

  @override
  String toJson(UniqueId object) => object.getOrCrash();
}
