class OkHiLocation {
  final String streetName;
  final double lat;
  final double lng;
  final String placeId;
  final String propertyName;
  final String directions;
  final String id;
  final String url;
  final String otherInformation;

  OkHiLocation({
    this.streetName,
    this.lat,
    this.lng,
    this.placeId,
    this.propertyName,
    this.directions,
    this.id,
    this.url,
    this.otherInformation,
  });

  OkHiLocation.fromJSON(Map<String, dynamic> parsedJSON)
      : this.streetName = parsedJSON['streetName'] ?? null,
        this.lat = parsedJSON['lat'] ?? null,
        this.lng = parsedJSON['lng'] ?? null,
        this.placeId = parsedJSON['placeId'] ?? null,
        this.propertyName = parsedJSON['propertyName'] ?? null,
        this.directions = parsedJSON['directions'] ?? null,
        this.id = parsedJSON['id'] ?? null,
        this.url = parsedJSON['url'] ?? null,
        this.otherInformation = parsedJSON['otherInformation'] ?? null;

  String get title {
    final String first = propertyName ?? '';
    final String second =
        first != '' && streetName != '' ? ', $streetName' : streetName ?? '';
    return first + second;
  }
}
