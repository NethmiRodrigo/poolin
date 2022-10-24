import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/custom/dashed_line.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/screens/shared/ride/map_screen.dart';
import 'package:poolin/utils/widget_functions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _sourceSearchFieldController = TextEditingController();
  final _destinationSearchFieldController = TextEditingController();

  String? apiKey = dotenv.env['MAPS_API_KEY'];

  DetailsResult? sourcePosition;
  DetailsResult? destinationPosition;

  late FocusNode sourceFocusNode;
  late FocusNode destinationFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(apiKey!);

    sourceFocusNode = FocusNode();
    destinationFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    sourceFocusNode.dispose();
    destinationFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  Widget searchField(String type, Function onClear, bool onClearCondition) {
    return TextField(
      controller: type == "source"
          ? _sourceSearchFieldController
          : _destinationSearchFieldController,
      autofocus: type == "source" ? true : false,
      enabled: type == "destination"
          ? _sourceSearchFieldController.text.isNotEmpty &&
              sourcePosition != null
          : true,
      focusNode: type == "source" ? sourceFocusNode : destinationFocusNode,
      style: BlipFonts.label,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: type == "source"
              ? "Where you start from"
              : "Where you want to go",
          suffixIcon: onClearCondition
              ? IconButton(
                  onPressed: () {
                    onClear();
                  },
                  icon: const Icon(Icons.clear_outlined),
                )
              : null),
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 1000), () {
          if (value.isNotEmpty) {
            autoCompleteSearch(value);
          } else {
            predictions = [];
            sourcePosition = null;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: Padding(
        padding: sidePadding,
        child: Column(
          children: [
            addVerticalSpace(44),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: BlipColors.black),
              ),
            ),
            addVerticalSpace(16),
            Row(
              children: [
                const Icon(
                  BlipIcons.source,
                  color: BlipColors.orange,
                ),
                addHorizontalSpace(10.0),
                Expanded(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Start",
                          style: BlipFonts.outline,
                        ),
                      ),
                      addVerticalSpace(8),
                      searchField("source", () {
                        setState(() {
                          predictions = [];
                          sourcePosition = null;
                          _sourceSearchFieldController.clear();
                        });
                      }, _sourceSearchFieldController.text.isNotEmpty),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 0.0),
                  child: CustomPaint(
                      size: const Size(1, 30),
                      painter: DashedLineVerticalPainter()),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  FluentIcons.location_16_filled,
                  color: BlipColors.orange,
                ),
                addHorizontalSpace(10.0),
                Expanded(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "End",
                          style: BlipFonts.outline,
                        ),
                      ),
                      addVerticalSpace(8),
                      searchField("destination", () {
                        setState(() {
                          predictions = [];
                          destinationPosition = null;
                          _destinationSearchFieldController.clear();
                        });
                      }, _destinationSearchFieldController.text.isNotEmpty),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(10.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: BlipColors.lightGrey,
                      radius: 15,
                      child: Icon(
                        FluentIcons.location_16_filled,
                        color: BlipColors.black,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                      style: BlipFonts.outline,
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId;
                      final details = await googlePlace.details.get(placeId!);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        if (sourceFocusNode.hasFocus) {
                          setState(() {
                            sourcePosition = details.result;
                            _sourceSearchFieldController.text =
                                details.result!.name!;
                            predictions = [];
                          });
                        } else {
                          setState(() {
                            destinationPosition = details.result;
                            _destinationSearchFieldController.text =
                                details.result!.name!;
                            predictions = [];
                          });
                        }

                        if (sourcePosition != null &&
                            destinationPosition != null) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Timer(const Duration(seconds: 1), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                    sourcePosition: sourcePosition,
                                    destinationPosition: destinationPosition),
                              ),
                            );
                          });
                        }
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
