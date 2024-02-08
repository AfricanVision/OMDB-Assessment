class Sort {

  String active;
  String direction;

  Sort(this.direction, this.active);

  Sort.fromJsonMap(Map<String, dynamic> map):
        active = map["active"],
        direction = map["direction"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['direction'] = direction;
    return data;
  }
}