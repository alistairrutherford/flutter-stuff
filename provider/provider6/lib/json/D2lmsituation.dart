import 'D2lmheaderInformation.dart';
import 'D2lmsituationRecord.dart';

class D2lmsituation {
    D2lmheaderInformation d2lmheaderInformation;
    D2lmsituationRecord d2lmsituationRecord;
    String id;

    D2lmsituation({this.d2lmheaderInformation, this.d2lmsituationRecord, this.id});

    factory D2lmsituation.fromJson(Map<String, dynamic> json) {
        return D2lmsituation(
            d2lmheaderInformation: json['d2lmheaderInformation'] != null ? D2lmheaderInformation.fromJson(json['d2lmheaderInformation']) : null, 
            d2lmsituationRecord: json['d2lmsituationRecord'] != null ? D2lmsituationRecord.fromJson(json['d2lmsituationRecord']) : null, 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.d2lmheaderInformation != null) {
            data['d2lmheaderInformation'] = this.d2lmheaderInformation.toJson();
        }
        if (this.d2lmsituationRecord != null) {
            data['d2lmsituationRecord'] = this.d2lmsituationRecord.toJson();
        }
        return data;
    }
}