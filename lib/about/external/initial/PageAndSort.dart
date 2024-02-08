

import 'Pageable.dart';
import 'Sort.dart';

class PageAndSort {
    
    String? query;

    Sort? sort;

    Pageable? page;

    PageAndSort({ this.query,  this.sort, this.page});

    factory PageAndSort.fromJson(Map<String, dynamic> json) {
        return PageAndSort(
            query: json['query'],
            sort: json['sort'] != null ? Sort.fromJsonMap(json['sort']) : null,
            page: json['page'] != null ? Pageable.fromJsonMap(json['page']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};

        if(page != null) {
            data['page'] = page;
        }
        if(sort != null) {
            data['sort'] = sort;
        }

        data['query'] = query;
        return data;
    }
}