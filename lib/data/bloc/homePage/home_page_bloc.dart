import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_page_repository.dart';
import '../../repository/user_repository.dart';
import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  UserRepository userRepository;
  HomePageRepository homePageRepository;

  HomePageBloc() {
    userRepository = UserRepository();
    homePageRepository = HomePageRepository();
  }

  @override
  HomePageState get initialState => ImageRecognitionInitialState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LogoutButtonPressed) {
      await userRepository.signOut();
      yield LogOutSuccess();
    } else if (event is ImageSelectionButtonSelected) {
      yield ImageRecognitionLoading();
      final List<String> outputs =
          await homePageRepository.classifyImage(event.image);

      if (outputs != null && outputs.length != 0) {
        yield ImageRecognitionImageIdentified(
          image: event.image,
          outputs: List.from(outputs),
        );
      } else {
        yield ImageRecognitionImageNotIdentified(
            image: event.image, errorMsg: "Error Identifying Image");
      }
    }
  }
}
