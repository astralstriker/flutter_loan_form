
import 'package:finmapp_assignment/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';
part 'option.g.dart';

@freezed
class Option with _$Option {
  const factory Option({@UniqueIdConvertor() required UniqueId key,required String value}) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}
