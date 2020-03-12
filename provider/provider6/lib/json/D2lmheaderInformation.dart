class D2lmheaderInformation {
    String d2lmconfidentiality;
    String d2lminformationStatus;

    D2lmheaderInformation({this.d2lmconfidentiality, this.d2lminformationStatus});

    factory D2lmheaderInformation.fromJson(Map<String, dynamic> json) {
        return D2lmheaderInformation(
            d2lmconfidentiality: json['d2lmconfidentiality'], 
            d2lminformationStatus: json['d2lminformationStatus'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['d2lmconfidentiality'] = this.d2lmconfidentiality;
        data['d2lminformationStatus'] = this.d2lminformationStatus;
        return data;
    }
}