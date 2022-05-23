import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/auth/auth_bloc.dart';
import '../../data/bloc/auth/auth_event.dart';
import '../../screens/login/login_screen.dart';
import '../main.dart';
import '../screens/bmicalculator/bmi_calculator.dart';
import '../screens/bmicalculator/bmi_calculator_form.dart';
import '../screens/bmicalculator/recommended_food_list.dart';
import '../screens/fooddiary/food_diary.dart';
import '../screens/home/home_page.dart';
import '../screens/libraryused/library_used_screen.dart';
import '../screens/register/register_screen.dart';
import 'custom_nav_animation.dart';

void jumpToRegisterPage({
  @required BuildContext context,
}) {
  Navigator.of(context).push(
    BouncePageRoute(
      alignment: Alignment.center,
      animationDuration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCirc,
      child: RegisterPageParent(),
    ),
  );
}

void jumpToHomePage({
  @required BuildContext context,
  @required User firebaseUser,
}) {
  Navigator.of(context).push(
    BouncePageRoute(
      alignment: Alignment.center,
      animationDuration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCirc,
      child: HomePageParent(
        firebaseUser: firebaseUser,
      ),
    ),
  );
}

void jumpToLoginPage({
  @required BuildContext context,
}) {
  Navigator.of(context).push(
    BouncePageRoute(
      alignment: Alignment.center,
      animationDuration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCirc,
      child: LoginPageParent(),
    ),
  );
}

void navigateToRootHome(BuildContext context) async {
  await Future.delayed(
    Duration(
      milliseconds: 1000,
    ),
  );
  Navigator.of(context).push(
    BouncePageRoute(
      alignment: Alignment.center,
      animationDuration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCirc,
      child: BlocProvider(
        create: (context) => AuthBloc()
          ..add(
            AppStartedEvent(),
          ),
        child: App(),
      ),
    ),
  );
}

void navigateToBMIPage(
    {@required BuildContext context, @required String username}) {
  Navigator.of(context).push(
    SlideTransitionPageRoute(
      direction: AxisDirection.left,
      child: BMICalculator(
        username: username,
      ),
      animationDuration: const Duration(milliseconds: 400),
    ),
  );
}

void navigateToProfilePage(
    {@required BuildContext context, @required String username}) {
  Navigator.of(context).push(
    SlideTransitionPageRoute(
      direction: AxisDirection.left,
      child: FoodDiary(
        username: username,
      ),
      animationDuration: const Duration(milliseconds: 400),
    ),
  );
}

void navigateToLibraryPage({@required BuildContext context}) {
  Navigator.of(context).push(
    SlideTransitionPageRoute(
      direction: AxisDirection.left,
      child: LibrariesPage(),
      animationDuration: const Duration(milliseconds: 400),
    ),
  );
}

void navigateToBMIForm(
    {@required BuildContext context,
    @required CollectionReference bmi,
    @required String username}) {
  Navigator.of(context).push(
    SlideTransitionPageRoute(
      direction: AxisDirection.up,
      child: BMICalculatorForm(
        bmi: bmi,
        username: username,
      ),
      animationDuration: const Duration(milliseconds: 400),
    ),
  );
}

void navigateToRecommendedFood(
    {@required BuildContext context, @required double bmi}) {
  Navigator.of(context).push(
    SlideTransitionPageRoute(
      direction: AxisDirection.up,
      child: RecommendedFood(
        bmi: bmi,
      ),
      animationDuration: const Duration(milliseconds: 400),
    ),
  );
}
