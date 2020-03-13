class LocationContainedInGroup {
    String predefinedLocationReference;
    String xsitype;

    LocationContainedInGroup({this.predefinedLocationReference, this.xsitype});

    factory LocationContainedInGroup.fromJson(Map<String, dynamic> json) {
        return LocationContainedInGroup(
            predefinedLocationReference: json['predefinedLocationReference'], 
            xsitype: json['xsitype'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['predefinedLocationReference'] = this.predefinedLocationReference;
        data['xsitype'] = this.xsitype;
        return data;
    }
}