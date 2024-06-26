import 'dart:io';

class CustomFile {
  final File? file;
  final String? url;

  CustomFile({this.file, this.url});

  @override
  String toString() {
    return file != null ? file!.path : 'https://api.imoveis.portalcatalao.com.br/${url!}';
  }
}
