

class Validator{

String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String?  validateEmail (String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null; // valid
}


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }

  final phoneRegExp = RegExp(r'^\d{10}$'); // 10-digit number
  if (!phoneRegExp.hasMatch(value)) {
    return 'Enter a valid 10-digit phone number';
  }

  return null;
}

  
  }