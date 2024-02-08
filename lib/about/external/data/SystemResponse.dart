
import 'ResponseState.dart';

class SystemResponse {

  String value;
  String key;
  String description;
  ResponseState state;

  SystemResponse(this.key, this.description,this.value, this.state);

  SystemResponse.fromJsonMap(Map<String, dynamic> map):
        value = map["value"],
        key = map["key"],
        description = map["description"],
        state = map["state"] is String ? ResponseState.values.firstWhere((element) =>  element.toString() == 'ResponseState.${map['state']}') : ResponseState.values[0];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['key'] = key;
    data['description'] = description;
    data['state'] = state.index;
    return data;
  }
}
