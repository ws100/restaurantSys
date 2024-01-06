import 'package:crypto/crypto.dart';
import 'dart:convert';

class QCloudAuthorization {
  static String calculateSignKey(String secretKey, String qKeyTime) {
    String data = '$qKeyTime';
    List<int> secretKeyBytes = utf8.encode(secretKey);
    List<int> dataBytes = utf8.encode(data);
  
    Hmac hmacSha1 = Hmac(sha1, secretKeyBytes);
    Digest hmacDigest = hmacSha1.convert(dataBytes);
  
    return hmacDigest.toString();
  }

  static String generateHttpString(String httpMethod, String httpURI, String httpParameters, String httpHeaders) {
    String httpString = '$httpMethod\n$httpURI\n$httpParameters\n$httpHeaders\n';
    return httpString;
  }

  static String generateStringToSign(String qSignAlgorithm, String qSignTime, String httpString) {
    String sha1Hash = sha1.convert(utf8.encode(httpString)).toString();
    String stringToSign = '$qSignAlgorithm\n$qSignTime\n$sha1Hash\n';
    return stringToSign;
  }

  static String generateSignature(String signKey, String stringToSign) {
    List<int> signKeyBytes = utf8.encode(signKey);
    List<int> stringToSignBytes = utf8.encode(stringToSign);
  
    Hmac hmacSha1 = Hmac(sha1, signKeyBytes);
    Digest hmacDigest = hmacSha1.convert(stringToSignBytes);
  
    return hmacDigest.toString();
  }

  static String generateAuthorization(String qSignAlgorithm, String secretId, String qSignTime, String qKeyTime, String qHeaderList, String qUrlParamList, String signature) {
    String authorization = "q-sign-algorithm=$qSignAlgorithm&q-ak=$secretId&q-sign-time=$qSignTime&q-key-time=$qKeyTime&q-header-list=$qHeaderList&q-url-param-list=$qUrlParamList&q-signature=$signature";
    return authorization;
  }
}
String generateKeyTime(int validDuration) {
  DateTime now = DateTime.now().toUtc();
  int startTimestamp = now.millisecondsSinceEpoch ~/ 1000;
  int endTimestamp = startTimestamp + validDuration;

  return '$startTimestamp;$endTimestamp';
}
// 示例用法：
String generateKey(String filename) {
  String secretKey = "填入key";
  String qKeyTime = generateKeyTime(3600);
  String httpMethod = "put";
  String httpURI = "/${filename}";
  String httpParameters = "";
  String httpHeaders = "填入地址";
  String qSignAlgorithm = "sha1";
  String secretId = "填入id";
  String qSignTime = generateKeyTime(3600);
  String qHeaderList = "host";
  String qUrlParamList = "";

  String signKey = QCloudAuthorization.calculateSignKey(secretKey, qKeyTime);
  String httpString = QCloudAuthorization.generateHttpString(httpMethod, httpURI, httpParameters, httpHeaders);
  String stringToSign = QCloudAuthorization.generateStringToSign(qSignAlgorithm, qSignTime, httpString);
  String signature = QCloudAuthorization.generateSignature(signKey, stringToSign);
  String authorization = QCloudAuthorization.generateAuthorization(qSignAlgorithm, secretId, qSignTime, qKeyTime, qHeaderList, qUrlParamList, signature);

  print("SignKey: $signKey");
  print("HttpString: $httpString");
  print("StringToSign: $stringToSign");
  print("Signature: $signature");
  print("Authorization: $authorization");
  return authorization;
}