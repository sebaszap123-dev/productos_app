class ErrorMessage {
  static String parseMessage(String message) {
    if (message == 'EMAIL_NOT_FOUND') return 'El correo no existe';
    if (message == 'EMAIL_EXISTS')
      return 'Ya existe una cuenta registrada con este correo';
    if (message == 'INVALID_PASSWORD')
      return 'La contraseña ingresada es incorrecta';
    return message;
  }
}
