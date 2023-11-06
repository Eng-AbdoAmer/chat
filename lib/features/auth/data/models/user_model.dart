class UserModel {
  String? name, phone, email, password, image, time, uId;
  late bool isActive;
  UserModel(
      {this.uId,
      this.password,
      this.email,
      this.name,
      this.phone,
      this.time,
      this.image,
      this.isActive = false});

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    time = json['time'];
    image = json['image'];
    isActive = json['isActive'];
  }
  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": image,
      "time": time,
      "isActive": isActive,
    };
  }
}
