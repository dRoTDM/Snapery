import 'package:bloc/bloc.dart';

import '../../repository/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;

  AuthBloc() {
    this.userRepository = UserRepository();
  }
  @override
  // TODO: implement initialState
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        var isSignedIn = await userRepository.isUserSignedIn();
        if (isSignedIn) {
          var user = await userRepository.getCurrentUser();
          yield AuthenicatedState(user: user);
        } else {
          yield UnAuthenicatedState();
        }
      } catch (e) {
        yield UnAuthenicatedState();
      }
    }
  }
}
