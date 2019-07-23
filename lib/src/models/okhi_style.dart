class OkHiStyle {
  final String color;
  final String logo;
  final String name;

  OkHiStyle({this.color, this.logo, this.name});

  Map<String, dynamic> toJSON() {
    final style = {"base": {}};

    if (color != null) style['base']['color'] = color;
    if (color != null) style['base']['logo'] = color;
    if (color != null) style['base']['name'] = color;

    return style;
  }
}
