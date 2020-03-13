
class HeaderInformation {
    String confidentiality;
    String informationStatus;

    HeaderInformation({this.confidentiality, this.informationStatus});

    factory HeaderInformation.fromJson(Map<String, dynamic> json) {
        return HeaderInformation(
            confidentiality: json['confidentiality'], 
            informationStatus: json['informationStatus'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['confidentiality'] = this.confidentiality;
        data['informationStatus'] = this.informationStatus;
        return data;
    }
}