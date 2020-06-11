import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerencia_de_estado/src/controller.dart';
import 'package:get/get.dart';

class NameSearch extends SearchDelegate<String> {
  HomeController controllerx = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controllerx.fetchDataFromApi();
    // return GetX<ControllerX>(
    //   builder: (_) {
    return StreamBuilder<List<String>>(
      stream: controllerx.names.stream,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (!snapshot.hasData) {
          return Center(
            child: Text('No data'),
          );
        }
        final results = snapshot.data
            .where((n) => n.toLowerCase().contains(query.toLowerCase()));
        return ListView(
          children: results
              .map<ListTile>((n) => ListTile(
                    title: Text(n),
                    leading: Icon(Icons.book),
                    onTap: () {
                      query = n;
                    },
                  ))
              .toList(),
        );
      },
    );
    //   },
    // );
  }
}

class ApiModel {
  final List<String> names;
  final l = <String>[];
  ApiModel({this.names});

  factory ApiModel.fromRawJson(String str) =>
      ApiModel.fromJson(json.decode(str));

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiModel(
      names: List<String>.from(json['names'].map((n) => n)).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        'names': names,
      };
}

class Api {
  Future<List<String>> getNames() async {
    return await Future<List<String>>.value(names);
  }

  Future<List<String>> getOtherNames() =>
      Future.delayed(Duration(seconds: 3), () => names);
}

final names = [
  'Felipe',
  'Fernanda',
  'Valentinne',
  'André',
  'Manoel',
  'Fernando',
  'Maria',
  'Emily',
  'Fabiano',
  'Margarida'
];
