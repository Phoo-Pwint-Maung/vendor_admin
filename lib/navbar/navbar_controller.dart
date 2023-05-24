import 'package:flutter/material.dart';

class NavBarController {
  final ExpansionTileController brandExpansionTile = ExpansionTileController();
  final ExpansionTileController categoryExpansionTile =
      ExpansionTileController();
  final ExpansionTileController businessExpansionTile =
      ExpansionTileController();
  final ExpansionTileController productExpansionTile =
      ExpansionTileController();
  final scroll = ScrollController();
}
