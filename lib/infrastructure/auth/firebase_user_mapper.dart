import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_pet/domain/auth/user.dart' as d;
import 'package:sky_pet/domain/core/value_objects.dart';

extension on User {
  d.User toDomain() {
    return d.User(
      id: UniqueId.fromUniqueString(uid),
      name: displayName,
      email: email,
    );
  }
}
