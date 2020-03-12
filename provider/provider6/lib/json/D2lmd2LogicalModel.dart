import 'D2lmexchange.dart';
import 'D2lmpayloadPublication.dart';

class D2lmd2LogicalModel {
    D2lmexchange d2lmexchange;
    D2lmpayloadPublication d2lmpayloadPublication;
    String modelBaseVersion;
    String xmlnsd2lm;
    String xmlnsjava;
    String xmlnsxalan;
    String xmlnsxsi;
    String xsischemaLocation;

    D2lmd2LogicalModel({this.d2lmexchange, this.d2lmpayloadPublication, this.modelBaseVersion, this.xmlnsd2lm, this.xmlnsjava, this.xmlnsxalan, this.xmlnsxsi, this.xsischemaLocation});

    factory D2lmd2LogicalModel.fromJson(Map<String, dynamic> json) {
        return D2lmd2LogicalModel(
            d2lmexchange: json['d2lmexchange'] != null ? D2lmexchange.fromJson(json['d2lmexchange']) : null, 
            d2lmpayloadPublication: json['d2lmpayloadPublication'] != null ? D2lmpayloadPublication.fromJson(json['d2lmpayloadPublication']) : null, 
            modelBaseVersion: json['modelBaseVersion'], 
            xmlnsd2lm: json['xmlnsd2lm'], 
            xmlnsjava: json['xmlnsjava'], 
            xmlnsxalan: json['xmlnsxalan'], 
            xmlnsxsi: json['xmlnsxsi'], 
            xsischemaLocation: json['xsischemaLocation'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['modelBaseVersion'] = this.modelBaseVersion;
        data['xmlnsd2lm'] = this.xmlnsd2lm;
        data['xmlnsjava'] = this.xmlnsjava;
        data['xmlnsxalan'] = this.xmlnsxalan;
        data['xmlnsxsi'] = this.xmlnsxsi;
        data['xsischemaLocation'] = this.xsischemaLocation;
        if (this.d2lmexchange != null) {
            data['d2lmexchange'] = this.d2lmexchange.toJson();
        }
        if (this.d2lmpayloadPublication != null) {
            data['d2lmpayloadPublication'] = this.d2lmpayloadPublication.toJson();
        }
        return data;
    }
}