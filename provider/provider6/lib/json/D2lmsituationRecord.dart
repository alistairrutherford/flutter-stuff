class D2lmsituationRecord {
    String id;

    D2lmsituationRecord({this.id});

    factory D2lmsituationRecord.fromJson(Map<String, dynamic> json) {
        return D2lmsituationRecord(
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        return data;
    }
}