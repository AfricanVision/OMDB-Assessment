
import 'package:omdbassestment/about/external/data/safe_convert.dart';

class RatingsResponse {
  final String source;
  final String value;

  RatingsResponse({
    this.source = "",
    this.value = "",
  });

  factory RatingsResponse.fromJson(Map<String, dynamic>? json) => RatingsResponse(
    source: asString(json, 'Source'),
    value: asString(json, 'Value'),
  );

  Map<String, dynamic> toJson() => {
    'Source': source,
    'Value': value,
  };
}