import 'D2lmpublicationCreator.dart';
import 'D2lmsituation.dart';

class D2lmpayloadPublication {
    D2lmpublicationCreator d2lmpublicationCreator;
    String d2lmpublicationTime;
    List<D2lmsituation> d2lmsituation;
    String lang;
    String xsitype;

    D2lmpayloadPublication({this.d2lmpublicationCreator, this.d2lmpublicationTime, this.d2lmsituation, this.lang, this.xsitype});

    factory D2lmpayloadPublication.fromJson(Map<String, dynamic> json) {
        return D2lmpayloadPublication(
            d2lmpublicationCreator: json['d2lmpublicationCreator'] != null ? D2lmpublicationCreator.fromJson(json['d2lmpublicationCreator']) : null, 
            d2lmpublicationTime: json['d2lmpublicationTime'], 
            d2lmsituation: json['d2lmsituation'] != null ? (json['d2lmsituation'] as List).map((i) => D2lmsituation.fromJson(i)).toList() : null, 
            lang: json['lang'], 
            xsitype: json['xsitype'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['d2lmpublicationTime'] = this.d2lmpublicationTime;
        data['lang'] = this.lang;
        data['xsitype'] = this.xsitype;
        if (this.d2lmpublicationCreator != null) {
            data['d2lmpublicationCreator'] = this.d2lmpublicationCreator.toJson();
        }
        if (this.d2lmsituation != null) {
            data['d2lmsituation'] = this.d2lmsituation.map((v) => v.toJson()).toList();
        }
        return data;
    }
}