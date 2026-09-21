class AccountModel {
  final String userName;
  final String maskedPhoneNumber;
  final double balance;
  final bool isSignedIn;

  const AccountModel({
    required this.userName,
    required this.maskedPhoneNumber,
    this.balance = 2450.50,
    this.isSignedIn = false,
  });

  AccountModel copyWith({
    String? userName,
    String? maskedPhoneNumber,
    double? balance,
    bool? isSignedIn,
  }) {
    return AccountModel(
      userName: userName ?? this.userName,
      maskedPhoneNumber: maskedPhoneNumber ?? this.maskedPhoneNumber,
      balance: balance ?? this.balance,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }
}
