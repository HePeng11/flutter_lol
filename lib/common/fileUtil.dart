import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

enum DirictoryType { temprary, appDocuments, externalStorage }

class FileUtils {
  ///获取文件 默认是缓存目录
  static Future<File> getLocalFile(String fileName,
      {DirictoryType dirictoryType = DirictoryType.temprary}) async {
    String dir = "";
    switch (dirictoryType) {
      case DirictoryType.temprary:
        dir = (await getTemporaryDirectory()).path;
        break;
      case DirictoryType.appDocuments:
        dir = (await getApplicationDocumentsDirectory()).path;
        break;
      case DirictoryType.externalStorage:
        dir = (await getExternalStorageDirectory()).path;
        break;
      default:
    }
    return new File('$dir/$fileName');
  }

  ///获取文件夹下的文件 默认是缓存目录
  static Future<List<FileSystemEntity>> getLocalDirFiles(String dir,
      {DirictoryType dirictoryType = DirictoryType.temprary}) async {
    Future<Directory> future;
    switch (dirictoryType) {
      case DirictoryType.temprary:
        future = getTemporaryDirectory();
        break;
      case DirictoryType.appDocuments:
        future = getApplicationDocumentsDirectory();
        break;
      case DirictoryType.externalStorage:
        future = getExternalStorageDirectory();
        break;
      default:
    }

    return future.then((root) {
      return new Directory('${root.path}/$dir').list().toList();
    });
  }

  ///读取文件 默认是缓存目录
  static Future<String> readFile(String fileName,
      {DirictoryType dirictoryType = DirictoryType.temprary}) async {
    try {
      File file = new File(fileName);
      String content = await file.readAsString();
      return content;
    } catch (e) {
      print('readFile failed ${e.message}');
      return '';
    }
  }

  ///append写文件 默认是缓存文件
  static void writeFile(String fileName, String content,
      {DirictoryType dirictoryType = DirictoryType.temprary,
      bool isFullName = false,
      FileMode mode = FileMode.append}) async {
    try {
      File file = isFullName
          ? new File(fileName)
          : await getLocalFile(fileName, dirictoryType: dirictoryType);
      _createDir(file.parent.uri.path);
      file.writeAsBytesSync(utf8.encode(content), mode: mode);
    } catch (e) {
      print('writeFile failed ${e.message}');
    }
  }

  static void _createDir(String dir) async {
    await Directory(dir).exists().then((exist) {
      if (!exist) {
        Directory(dir).create(recursive: true);
      }
    });
  }
}
