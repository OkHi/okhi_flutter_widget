import 'package:meta/meta.dart';

class OkHiAuth {
  final String apiKey;

  OkHiAuth({@required this.apiKey});

  Map<String, String> toJSON() {
    return {"apiKey": apiKey};
  }
}
