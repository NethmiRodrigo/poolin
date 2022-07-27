import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/dashed_line.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/shared/ride/map_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: BlipColors.white,
        leading: const BackButton(color: BlipColors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_pin,
                  color: BlipColors.orange,
                ),
                addHorizontalSpace(10.0),
                Expanded(
                  child: TextField(
                    controller: _sourceSearchFieldController,
                    autofocus: false,
                    focusNode: sourceFocusNode,
                    style: BlipFonts.label,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Source",
                        hintStyle: BlipFonts.label,
                        filled: true,
                        fillColor: BlipColors.lightGrey,
                        contentPadding: const EdgeInsets.all(8.0),
                        suffixIcon: _sourceSearchFieldController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    predictions = [];
                                    sourcePosition = null;
                                    _sourceSearchFieldController.clear();
                                  });
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
                  ),
                ),
                addHorizontalSpace(10.0),
                Text(
                  "Start location",
                  style: Theme.of(context).textTheme.labelMedium,
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
                  Icons.location_pin,
                  color: BlipColors.orange,
                ),
                addHorizontalSpace(10.0),
                Expanded(
                  child: TextField(
                    controller: _destinationSearchFieldController,
                    autofocus: false,
                    focusNode: destinationFocusNode,
                    enabled: _sourceSearchFieldController.text.isNotEmpty &&
                        sourcePosition != null,
                    style: BlipFonts.label,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Destination",
                        hintStyle: BlipFonts.label,
                        filled: true,
                        fillColor: BlipColors.lightGrey,
                        contentPadding: const EdgeInsets.all(8.0),
                        suffixIcon: _destinationSearchFieldController
                                .text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    predictions = [];
                                    destinationPosition = null;
                                    _destinationSearchFieldController.clear();
                                  });
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
                          destinationPosition = null;
                        }
                      });
                    },
                  ),
                ),
                addHorizontalSpace(10.0),
                Text(
                  "End location",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            addVerticalSpace(10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: predictions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: BlipColors.lightGrey,
                    radius: 15,
                    child: Icon(
                      Icons.location_pin,
                      color: BlipColors.orange,
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
                    if (details != null && details.result != null && mounted) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                  sourcePosition: sourcePosition,
                                  destinationPosition: destinationPosition),
                            ));
                      }
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
