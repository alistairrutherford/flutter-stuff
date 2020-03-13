class ValidityTimeSpecification {
    String overallStartTime;

    ValidityTimeSpecification({this.overallStartTime});

    factory ValidityTimeSpecification.fromJson(Map<String, dynamic> json) {
        return ValidityTimeSpecification(
            overallStartTime: json['overallStartTime'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['overallStartTime'] = this.overallStartTime;
        return data;
    }
}