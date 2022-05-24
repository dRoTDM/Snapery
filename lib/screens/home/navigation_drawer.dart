import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/app_navigation.dart';
import '../../data/bloc/homePage/home_page_bloc.dart';
import '../../data/bloc/homePage/home_page_event.dart';
import '../../screens/constants/ic_config.dart';

class NavigationDrawerParent extends StatelessWidget {
  final User firebaseUser;
  const NavigationDrawerParent({Key key, @required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: NavigationDrawer(
        firebaseUser: firebaseUser,
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final User firebaseUser;
  NavigationDrawer({Key key, @required this.firebaseUser}) : super(key: key);
  HomePageBloc homePageBloc;

  @override
  Widget build(BuildContext context) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    return Drawer(
      child: Container(
        color: Colors.deepPurpleAccent,
        child: ListView(
          children: <Widget>[
            SvgPicture.asset(
              IconLogo,
              color: Colors.white,
              height: 250,
              width: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(firebaseUser.photoURL ??
                        "https://cdn3.iconfinder.com/data/icons/black-easy/512/538642-user_512x512.png"),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Signed in as: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          firebaseUser.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                navigateToProfilePage(
                  context: context,
                  username: firebaseUser.email,
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text("Food Diary",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToBMIPage(
                    context: context, username: firebaseUser.email);
              },
              child: ListTile(
                leading: Icon(
                  Icons.ballot_sharp,
                  color: Colors.white,
                ),
                title: Text("BMI Calculator",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToLibraryPage(context: context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.ballot_sharp,
                  color: Colors.white,
                ),
                title: Text("Libraries Used",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            Divider(
              color: Colors.white70,
            ),
            GestureDetector(
              onTap: () {
                homePageBloc.add(
                  LogoutButtonPressed(),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text("Logout",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
