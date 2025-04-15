class ContactsModel {
  int? excludedId;
  int? userId;
  String? excludedContactNumber;
  String? excludedContactName;
  String? reason;
  String? excludedAt;
  String? updatedAt;

  ContactsModel(
      {this.excludedId,
      this.userId,
      this.excludedContactNumber,
      this.excludedContactName,
      this.reason,
      this.excludedAt,
      this.updatedAt});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    excludedId = json['excluded_id'];
    userId = json['user_id'];
    excludedContactNumber = json['excluded_contact_number'];
    excludedContactName = json['excluded_contact_name'];
    reason = json['reason'];
    excludedAt = json['excluded_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['excluded_id'] = this.excludedId;
    data['user_id'] = this.userId;
    data['excluded_contact_number'] = this.excludedContactNumber;
    data['excluded_contact_name'] = this.excludedContactName;
    data['reason'] = this.reason;
    data['excluded_at'] = this.excludedAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
