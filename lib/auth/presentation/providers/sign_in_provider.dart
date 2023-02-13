import 'package:deliverzler/auth/domain/entities/user.dart';
import 'package:deliverzler/auth/domain/use_cases/sign_in_with_email_uc.dart';
import 'package:deliverzler/auth/presentation/providers/auth_state_provider.dart';
import 'package:deliverzler/core/presentation/providers/provider_utils.dart';
import 'package:deliverzler/core/presentation/utils/functional.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.
@riverpod
AsyncValue<Option<User>> signInState(SignInStateRef ref) {
  ref.listenSelf((previous, next) {
    next.whenOrNull(
      //If the call emitted an error state, signInWithEmailEventProvider will be invalidated which will
      //lead to invalidating signInWithEmailProvider too, so that you'll be able to retry the api call again.
      error: (_, __) => ref.invalidate(signInWithEmailEventProvider),
      data: (user) {
        if (user is Some<User>) {
          ref
              .read(authStateControllerProvider.notifier)
              .authenticateUser(user.value);
        }
      },
    );
  });

  final event = ref.watch(signInWithEmailEventProvider);
  return event.match(
    () => const AsyncData(None()),
    (params) {
      return ref
          .watch(signInWithEmailProvider(params))
          .whenData((user) => Some(user));
    },
  );
}

@riverpod
class SignInWithEmailEvent extends _$SignInWithEmailEvent with NotifierUpdate {
  @override
  Option<SignInWithEmailParams> build() => const None();
}

@riverpod
Future<User> signInWithEmail(
  SignInWithEmailRef ref,
  SignInWithEmailParams params,
) async {
  return ref.watch(signInWithEmailUCProvider).call(params);
}
