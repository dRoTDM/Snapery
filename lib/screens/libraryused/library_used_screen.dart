import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/app_bar_title.dart';
import 'library_list_view.dart';

class LibrariesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.deepPurpleAccent,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 50,
              floating: true,
              pinned: true,
              elevation: 0,
              // ignore: sized_box_for_whitespace
              flexibleSpace: Container(
                color: Colors.deepPurpleAccent,
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const AppBarTitle(title: "Open Source Libraries"),
                        Container(
                          width: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const LibraryListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
