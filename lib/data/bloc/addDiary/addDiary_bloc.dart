import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_page_repository.dart';
import '../../repository/user_repository.dart';
import 'addDiary_event.dart';
import 'addDiary_state.dart';

class AddDiaryBloc extends Bloc<AddDiaryEvent, AddDiaryState> {
  UserRepository userRepository;
  HomePageRepository homePageRepository;

  AddDiaryBloc() {
    userRepository = UserRepository();
    homePageRepository = HomePageRepository();
  }

  @override
  AddDiaryState get initialState => AddToFoodDiaryInitial();

  @override
  Stream<AddDiaryState> mapEventToState(AddDiaryEvent event) async* {
    if (event is AddFoodDiaryButtonSelected) {
      yield AddToFoodDiaryInitial();

      try {
        homePageRepository.addToFoodDiary(
          foodDiary: event.foodDiary,
          username: event.username,
          name: event.name,
          calories: event.calories,
          carbohydrate: event.carbohydrate,
          protein: event.protein,
          fat: event.fat,
        );
        yield AddToFoodDiarySuccessState(
            successMsg: "Successfully Added to Food Library");
      } catch (e) {
        yield AddToFoodDiaryFailState(errorMsg: "Error Adding to the Diary");
      }
    }
  }
}
