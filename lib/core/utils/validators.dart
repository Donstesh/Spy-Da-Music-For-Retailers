class Validators {
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    final RegExp phoneRegex = RegExp(
      r'^[\+]?[0-9\s\-\(\)]{10,}$',
    );
    return phoneRegex.hasMatch(phone);
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!isValidEmail(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (!isValidPhone(value.trim())) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }
}