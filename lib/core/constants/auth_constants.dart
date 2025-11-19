class AuthConstants {
  static const regexEmail = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  static const regexPassword = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
  static const regexName = r"^[a-zA-Zа-яА-ЯёЁ]*$";
}