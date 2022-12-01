import 'package:android/models/models.dart';

Future<getUserOutput> userOutputJsonConverter(Map<String, dynamic> json) async {
  Account acc = await accountJsonConverter(json);

  return getUserOutput(
    status: "OK",
    account: acc,
  );
}

class getUserOutput {
  final String status;
  final Account? account;

  getUserOutput({required this.status, this.account});

  factory getUserOutput.fromJson(Map<String, dynamic> json) {
    return getUserOutput(
      status: "OK",
      account: Account.fromJson(json),
    );
  }
}