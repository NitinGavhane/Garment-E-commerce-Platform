enum UserRole {
  user,
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final double walletBalance;
  final String referralCode;
  final bool isVerified;
  final UserRole role;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.walletBalance = 0,
    this.referralCode = '',
    this.isVerified = true,
    this.role = UserRole.user,
  });
}
