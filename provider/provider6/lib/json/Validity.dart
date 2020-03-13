import 'package:provider6/json/ValidityTimeSpecification.dart';

class Validity {
    String validityStatus;
    ValidityTimeSpecification validityTimeSpecification;

    Validity({this.validityStatus, this.validityTimeSpecification});

    factory Validity.fromJson(Map<String, dynamic> json) {
        return Validity(
            validityStatus: json['validityStatus'], 
            validityTimeSpecification: json['validityTimeSpecification'] != null ? ValidityTimeSpecification.fromJson(json['validityTimeSpecification']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['validityStatus'] = this.validityStatus;
        if (this.validityTimeSpecification != null) {
            data['validityTimeSpecification'] = this.validityTimeSpecification.toJson();
        }
        return data;
    }
}