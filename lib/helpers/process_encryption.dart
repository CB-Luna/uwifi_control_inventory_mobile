import 'package:encrypt/encrypt.dart';

// void main(List<String> args) {
//   // //print("Primer método con crypto: ${encryptAESCryptoJS("Carmen2022", 'HuxR1bZVNumSBLEN')}");
//   //print("Password: ${processEncryption('Ememi.2022')}");
// }

String? processEncryption(String password) {
  try {
    var key = Key.fromUtf8('HuxR1bZVNumSBLEN');
    var srcs = password;
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: "PKCS7"));
    var encrypted = encrypter.encrypt(srcs.toString(), iv: iv);
    return encrypted.base64;
  } catch (error) {
    //print("Error en Process Encyption: $error");
    return null;
  }
}
