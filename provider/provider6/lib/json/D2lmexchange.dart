import 'D2lmsupplierIdentification.dart';

class D2lmexchange {
    D2lmsupplierIdentification d2lmsupplierIdentification;

    D2lmexchange({this.d2lmsupplierIdentification});

    factory D2lmexchange.fromJson(Map<String, dynamic> json) {
        return D2lmexchange(
            d2lmsupplierIdentification: json['d2lmsupplierIdentification'] != null ? D2lmsupplierIdentification.fromJson(json['d2lmsupplierIdentification']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.d2lmsupplierIdentification != null) {
            data['d2lmsupplierIdentification'] = this.d2lmsupplierIdentification.toJson();
        }
        return data;
    }
}