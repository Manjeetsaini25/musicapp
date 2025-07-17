import 'package:client/features/auth/model/user_modal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currentuser_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel user) {
    state = user;
  }
}