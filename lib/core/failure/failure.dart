abstract class Failure 
{
  final int code;
  final String message;

  Failure({required this.code, required this.message});

  String getLocalizedString();
}