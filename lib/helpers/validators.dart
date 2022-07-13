class Validators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) return "Kolom tidak boleh kosong";
    return null;
  }

  static String? email(String? value) {
    if (value == null ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) return "Kolom harus berisi email";
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || !RegExp(r"\+?([ -]?\d+)+|\(\d+\)([ -]\d+)").hasMatch(value)) {
      return "Kolom harus berisi nomor telepon";
    }
    return null;
  }
}
