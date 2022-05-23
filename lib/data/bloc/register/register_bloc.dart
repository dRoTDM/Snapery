import 'package:snapery/data/bloc/register/register_event.dart';
import 'package:snapery/data/bloc/register/register_state.dart';
import 'package:snapery/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;

  RegisterBloc() {
    userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterIntialState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SignUpButtonPressedEvent) {
      try {
        yield RegisterLoadingState();
        var user = await userRepository.createUser(event.email, event.password);
        yield RegisterSuccessfulState(user: user);
      } catch (e) {
        yield RegisterFailureState(
            errorMsg:
                "An error occured! Please check your Internet connection or try again later");
      }
    }
  }
}
