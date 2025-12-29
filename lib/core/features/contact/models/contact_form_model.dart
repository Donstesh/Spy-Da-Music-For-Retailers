class ContactFormData {
  String businessName;
  String contactName;
  String email;
  String phone;
  String businessType;
  int locations;
  String interestedPlan;
  String message;
  bool requestCallback;

  ContactFormData({
    this.businessName = '',
    this.contactName = '',
    this.email = '',
    this.phone = '',
    this.businessType = '',
    this.locations = 1,
    this.interestedPlan = '',
    this.message = '',
    this.requestCallback = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'contact_name': contactName,
      'email': email,
      'phone': phone,
      'business_type': businessType,
      'locations': locations,
      'interested_plan': interestedPlan,
      'message': message,
      'request_callback': requestCallback ? 1 : 0,
    };
  }

  bool validate() {
    return businessName.isNotEmpty &&
        contactName.isNotEmpty &&
        email.isNotEmpty &&
        businessType.isNotEmpty;
  }
}