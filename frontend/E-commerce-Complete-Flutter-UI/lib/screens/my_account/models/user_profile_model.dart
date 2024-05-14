class UserProfileModel {
  String? id;
  String? fullname;
  String? email;
  String? gender;

  UserProfileModel({this.id, this.fullname, this.email, this.gender});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['gender'] = this.gender;
    return data;
  }
}

