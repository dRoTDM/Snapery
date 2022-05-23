import 'package:snapery/data/bloc/login/login_event.dart';
import 'package:snapery/data/bloc/login/login_state.dart';
import 'package:snapery/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc() {
    this.userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginButtonPressed) {
      try {
        yield LoginLoadingState();
        var user = await userRepository.signInUser(event.email, event.password);
        yield LoginSuccessfulState(user: user);
      } catch (e) {
        yield LoginFailureState(
          errorMsg: "Please check your Internet connection and credentials",
        );
      }
    }
    // else if (event is GoogleSignInButtonPressed){
    //   try{
    //     yield GoogleSignInLoadingState();
    //     var user = await userRepository.googleSignIn();
    //     yield LoginSuccessfulState(user: user);
    //   }
    //   catch(e){
    //     yield GoogleSignFailureState(
    //       errorMsg: "Please check your Internet connection and credentials",
    //     );
    //   }
    // }
  }
}
