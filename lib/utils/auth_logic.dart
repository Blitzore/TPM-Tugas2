class AuthLogic {
  // Simulasi tabel database user
  static final Map<String, String> _mockDatabase = {
    "gilang": "123230060",
    "ahmad": "123230077",
    "remon": "123230129",
    "laksa": "123230235",
  };

  // Fungsi murni untuk validasi
  static bool login(String username, String password) {
    if (_mockDatabase.containsKey(username)) {
      return _mockDatabase[username] == password;
    }
    return false;
  }
}