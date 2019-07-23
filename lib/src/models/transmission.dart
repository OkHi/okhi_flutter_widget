import 'dart:convert';

class Transmission {
  final String message;
  final Map<String, dynamic> payload;

  Transmission({
    this.message,
    this.payload,
  });

  Transmission.fromJSON(Map<String, dynamic> parsedJSON)
      : message = parsedJSON['message'],
        payload = parsedJSON['payload'] is Map
            ? parsedJSON['payload']
            : {"body": parsedJSON['payload']};

  String toJSON() {
    final Map<String, dynamic> transmission = {};
    transmission['message'] = message;
    transmission['payload'] = payload;
    return json.encode(transmission);
  }
}
