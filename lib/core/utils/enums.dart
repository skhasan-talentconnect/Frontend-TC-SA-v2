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
