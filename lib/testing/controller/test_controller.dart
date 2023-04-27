import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vendor_admin/api/default_api.dart';
import 'package:vendor_admin/provider/providers.dart';
import 'package:vendor_admin/testing/model/test_model.dart';
import 'package:provider/provider.dart';

// Functions and controller for test screen
class TestController {
  final scrollcontroller = ScrollController();
  final texteditingController = TextEditingController();

  void searchPlayLists(BuildContext context) {
    Provider.of<PlayLists>(context, listen: false).searchText = '';
    Provider.of<PlayLists>(context, listen: false).allList.clear();
    Provider.of<PlayLists>(context, listen: false)
        .search(search: texteditingController.text);

    GetInfo().getInfo(context);
  }
}

// Testing with spotify api
class GetInfo {
  void getInfo(BuildContext context) async {
    String searching =
        Provider.of<PlayLists>(context, listen: false).searchText;
    final Response response = await GetApi().getApi(
      endPoint:
          "search/?q=$searching&type=multi&offset=0&limit=10&numberOfTopResults=5",
      apiKey: "86c1164fe6msh4079b0a2b08dd04p1f66f0jsn7376f9deb601",
      apiHost: "spotify23.p.rapidapi.com",
    );

    final List totalList = jsonDecode(response.body)["tracks"]["items"] as List;

    String songName;
    String albumPhoto;
    String artistName;

    for (var i = 0; i < totalList.length; i++) {
      songName = totalList[i]["data"]["name"];
      albumPhoto =
          totalList[i]["data"]["albumOfTrack"]["coverArt"]["sources"][0]["url"];

      artistName =
          totalList[i]["data"]["artists"]["items"][0]["profile"]["name"];

      context.read<PlayLists>().addPlayList(
          value: PlayList(
              songName: songName,
              albumPhoto: albumPhoto,
              artistName: artistName));
    }
  }
}

class PlayLists extends ChangeNotifier {
  List allList = [];
  String searchText = '';

  void search({required String search}) {
    searchText = search;
    notifyListeners();
  }

  void addPlayList({required PlayList value}) {
    allList.add(value);
    notifyListeners();
  }
}
