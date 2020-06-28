class User {
  String accessToken;
  String tokenType;
  String expiresAt;
  UserDetails userDetails;

  User({this.accessToken, this.tokenType, this.expiresAt, this.userDetails});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    return data;
  }
}

class UserDetails {
  int uid;
  String name;
  String email;
  String photoURL;

  UserDetails({this.uid, this.name, this.email, this.photoURL});

  UserDetails.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photoURL'] = this.photoURL;
    return data;
  }
}