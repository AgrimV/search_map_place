part of search_map_place;

class Place {
  Place(
    Geocoding geocode, {
    required this.description,
    required this.placeId,
    required this.types,
  }) {
    this._geocode = geocode;
  }

  Place.fromJSON(place, Geocoding geocode) {
    try {
      this.description = place["description"];
      this.placeId = place["place_id"];
      this.types = place["types"];

      this._geocode = geocode;
      this.fullJSON = place;
    } catch (e) {
      print("The argument you passed for Place is not compatible.");
    }
  }

  /// Contains the human-readable name for the returned result. For establishment results, this is usually the business name.
  late String description;

  /// A textual identifier that uniquely identifies a place. To retrieve information about the place, pass this identifier in the placeId field of a Places API request. For more information about place IDs, see the [Place IDs](https://developers.google.com/places/web-service/place-id) overview.
  late String placeId;

  /// Contains an array of types that apply to this place. For example:
  /// ```
  /// [ "political", "locality" ]
  /// ```
  /// or
  /// ```
  /// [ "establishment", "geocode", "beauty_salon" ]
  /// ```
  /// The array can contain multiple values. Learn more about [Place types](https://developers.google.com/places/web-service/supported_types).
  late List<dynamic> types;

  /// Has the full JSON response received from the Places API. Can be used to extract extra information. More info on the [Places Autocomplete API documentation](https://developers.google.com/places/web-service/autocomplete)
  ///
  /// All of its information can be accessed like a regular [Map]. For example:
  /// ```
  /// fullJSON["structured_formating"]["main_text"]
  /// ```
  var fullJSON;

  late Geocoding _geocode;
  late Geolocation _geolocation;

  /// Fetches the Geolocation API from Google Maps to get more information about the place, including coordinates, bounds, etc.
  ///
  /// Learn more at [Geolocation docs](https://developers.google.com/maps/documentation/geolocation/intro)
  Future<Geolocation> get geolocation async {
    this._geolocation = await _geocode.getGeolocation(description);
    return _geolocation;
  }
}
