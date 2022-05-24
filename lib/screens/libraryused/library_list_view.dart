import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../data/model/library_data_model.dart';

class LibraryListView extends StatelessWidget {
  const LibraryListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21.0, right: 22),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Libraries We Use",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Text(
                  "The following sets forth attribution notices for third party software that way be contained in portions of the Fitby product. We thank the open source community for all their contributions.",
                  maxLines: 10,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: readJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return const Center(
                    child: Text('Error loading the json data'),
                  );
                } else if (data.hasData) {
                  final items = data.data as List<LibraryDataModel>;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.isEmpty ? 0 : items.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Column(
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                items[index].name.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    items[index].license.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                  );
                } else {
                  return Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  );
                }
              }),
        ],
      ),
    );
  }

  static Future<List<LibraryDataModel>> readJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/library.json');

    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list
        .map((e) => LibraryDataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
