package json

class Situation {
    HeaderInformation headerInformation;
    String id;
    SituationRecord situationRecord;

    Situation({this.headerInformation, this.id, this.situationRecord});

    factory Situation.fromJson(Map<String, dynamic> json) {
        return Situation(
            headerInformation: json['headerInformation'] != null ? HeaderInformation.fromJson(json['headerInformation']) : null, 
            id: json['id'], 
            situationRecord: json['situationRecord'] != null ? SituationRecord.fromJson(json['situationRecord']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.headerInformation != null) {
            data['headerInformation'] = this.headerInformation.toJson();
        }
        if (this.situationRecord != null) {
            data['situationRecord'] = this.situationRecord.toJson();
        }
        return data;
    }
}