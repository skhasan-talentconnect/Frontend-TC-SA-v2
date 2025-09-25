enum UserType { student, parent, school, guest }

enum AuthProvider { google, email }

extension UserTypeExt on UserType {
  String get label {
    switch (this) {
      case UserType.student:
        return 'student';
      case UserType.parent:
        return 'parent';
      case UserType.school:
        return 'school';
      case UserType.guest:
        return 'guest';
    }
  }

  static UserType fromValue(String value) {
    switch (value) {
      case 'student':
        return UserType.student;
      case 'parent':
        return UserType.parent;
      case 'school':
        return UserType.school;
      case 'guest':
        return UserType.guest;
      default:
        return UserType.guest;
    }
  }
}

extension AuthProviderExt on AuthProvider {
  String get label {
    switch (this) {
      case AuthProvider.email:
        return 'email';
      case AuthProvider.google:
        return 'google';
    }
  }
}
