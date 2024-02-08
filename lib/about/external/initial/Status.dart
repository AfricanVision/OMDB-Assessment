
class Status {
    String? status;
    String? color;

    Status({this.status, this.color});

    factory Status.fromJson(Map<String, dynamic> json) {
        return Status(
            status: json['status'], 
            color: json['color'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['status'] = status;
        data['color'] = color;
        return data;
    }
}