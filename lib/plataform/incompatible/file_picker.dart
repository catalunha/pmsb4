import 'package:pmsb4/plataform/incompatible/empty.dart';

class FilePicker extends Empty {
  static dynamic getFilePath({dynamic type, dynamic fileExtension}) {}

  static dynamic getMultiFilePath({dynamic type, dynamic fileExtension}) {}
}

class FileType extends Empty {
  static dynamic any;
  static dynamic image;
  static dynamic custom;
}
