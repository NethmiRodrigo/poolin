import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';

class PlacesService {
  String? apiKey = dotenv.env['MAPS_API_KEY'];
  late GooglePlace googlePlace = GooglePlace(apiKey!);
  AutocompleteResponse? results;

  Future<List<AutocompletePrediction>> getAutoComplete(String search) async {
    if (search.isNotEmpty) {
      results = await googlePlace.autocomplete.get(search);
      if (results != null && results!.predictions != null) {
        return results?.predictions ?? [];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<DetailsResult?> getPlace(String placeId) async {
    var result = await googlePlace.details.get(placeId);
    if (result != null && result.result != null) {
      return result.result;
    }
    return null;
  }
}
