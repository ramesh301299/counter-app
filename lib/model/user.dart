class User {
  final String username;
  final String password; // Demo only (plain text). Real apps: hash it.

  User({required this.username, required this.password});
}