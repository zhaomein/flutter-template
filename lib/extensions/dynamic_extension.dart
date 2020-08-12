extension DynamicExtension on dynamic {
  String get tag => this.runtimeType.toString();
}