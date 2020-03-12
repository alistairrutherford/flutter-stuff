package json

class PayloadPublication {
    String lang;
    PublicationCreator publicationCreator;
    String publicationTime;
    List<Situation> situation;
    String xsitype;

    PayloadPublication({this.lang, this.publicationCreator, this.publicationTime, this.situation, this.xsitype});

    factory PayloadPublication.fromJson(Map<String, dynamic> json) {
        return PayloadPublication(
            lang: json['lang'], 
            publicationCreator: json['publicationCreator'] != null ? PublicationCreator.fromJson(json['publicationCreator']) : null, 
            publicationTime: json['publicationTime'], 
            situation: json['situation'] != null ? (json['situation'] as List).map((i) => Situation.fromJson(i)).toList() : null, 
            xsitype: json['xsitype'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['lang'] = this.lang;
        data['publicationTime'] = this.publicationTime;
        data['xsitype'] = this.xsitype;
        if (this.publicationCreator != null) {
            data['publicationCreator'] = this.publicationCreator.toJson();
        }
        if (this.situation != null) {
            data['situation'] = this.situation.map((v) => v.toJson()).toList();
        }
        return data;
    }
}