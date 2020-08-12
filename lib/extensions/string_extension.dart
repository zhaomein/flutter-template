extension StringExtension on String {
  String ucFirst() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String trimLeftChars(String pattern){
    if( (this??'').isEmpty || (pattern??'').isEmpty || pattern.length>this.length ) return this;

    String newText = this.toString();

    while( newText.startsWith(pattern) ){
      newText = newText.substring(pattern.length);
    }
    return newText;
  }

  String trimRightChars(String pattern){
    if( (this??'').isEmpty || (pattern??'').isEmpty || pattern.length>this.length ) return this;

    String newText = this.toString();

    while( newText.endsWith(pattern) ){
      newText = newText.substring(0, newText.length-pattern.length);
    }
    return newText;
  }

  String trim(String pattern){
    return trimLeftChars(pattern).trimRightChars(pattern);
  }

  String map(Map map) {
    String str = this.toString();
    map.forEach((key, value) {
      str = str.replaceFirst("{$key}", value);
    });
    return str;
  }
}