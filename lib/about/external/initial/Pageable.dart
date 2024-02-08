class Pageable {

  int pageIndex;
  int previousPageIndex;
  int pageSize;
  int length;

  Pageable(this.previousPageIndex, this.pageIndex,this.pageSize, this.length);

  Pageable.fromJsonMap(Map<String, dynamic> map):
        length = map["length"],
        pageIndex = map["pageIndex"],
        pageSize = map["pageSize"],
        previousPageIndex = map["previousPageIndex"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['previousPageIndex'] = previousPageIndex;
    data['pageSize'] = pageSize;
    data['length'] = length;
    return data;
  }
}