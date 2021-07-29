import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sky_pet/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({required UniqueId id, String? email, String? name}) =
      _User;
}
