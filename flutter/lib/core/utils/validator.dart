class Validator {
  /// Helper method to validate for malicious patterns

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Email-specific validation
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    final RegExp emailRegexTwo = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (!emailRegexTwo.hasMatch(value)) {
      return 'Enter valid Gmail address ending with @gmail.com';
    }

    return null; // Email is valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    // Password-specific validation
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[#?!@$%^&*-]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  static String? validateConfirmPassword(String? value, password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }

    // Password-specific validation
    if (password != value) {
      return 'Passwords do not match';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[#?!@$%^&*-]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    // Phone-specific validation
    if (value.length != 11) {
      return 'Phone number must be 11 digits long';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'Phone number must be 11 digits and contain only numbers';
    }
    return null; // Phone number is valid
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }

    return null; // Name is valid
  }
}
