extension MapStringPrettier on Map<String, dynamic>? {
  //for logging purposes
  String prettify() {
    if (this == null) return '';

    String prettyString = '\n';

    this!.forEach((key, value) {
      prettyString += '$key: $value\n';
    });

    return prettyString;
  }
}
