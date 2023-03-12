
class Header{
  static const String contentType = 'content-type';
  static const String accept = 'accept';

  //Header values
  static const String contentTypeValue = 'application/json';
  static const String acceptValue = 'application/json';

  static Future<Map<String, String>> get fullHeader async{
    return {
      contentType: contentTypeValue,
      accept : acceptValue,
    };
  }
}