package json

class GroupOfLocations {
    LocationContainedInGroup locationContainedInGroup;
    String predefinedLocationSetReference;
    String xsitype;

    GroupOfLocations({this.locationContainedInGroup, this.predefinedLocationSetReference, this.xsitype});

    factory GroupOfLocations.fromJson(Map<String, dynamic> json) {
        return GroupOfLocations(
            locationContainedInGroup: json['locationContainedInGroup'] != null ? LocationContainedInGroup.fromJson(json['locationContainedInGroup']) : null, 
            predefinedLocationSetReference: json['predefinedLocationSetReference'], 
            xsitype: json['xsitype'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['predefinedLocationSetReference'] = this.predefinedLocationSetReference;
        data['xsitype'] = this.xsitype;
        if (this.locationContainedInGroup != null) {
            data['locationContainedInGroup'] = this.locationContainedInGroup.toJson();
        }
        return data;
    }
}