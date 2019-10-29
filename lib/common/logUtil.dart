import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hp_demo1/routes/logview.dart';
import 'fileUtil.dart';
import 'datetime_util.dart';

const bool isDevelopeEnvironment = true;

class LogUtil {
  ///记录log
  static void log(String str, String fromWhere, {BuildContext context}) {
    if (context != null) {
      final snackBar = new SnackBar(
        content:
            new Text('$str${isDevelopeEnvironment ? ' at ' + fromWhere : ''}'),
        action: isDevelopeEnvironment
            ? new SnackBarAction(
                label: '查看日志',
                onPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return LogView();
                  }));
                },
              )
            : null,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    var msg =
        '[${DatetimeUtil.toLongString(DateTime.now())} at $fromWhere]【$str】';
    print('error---------------$msg');
    FileUtils.writeFile(
        'logs/${DatetimeUtil.toShortString(DateTime.now())}.txt', '$msg \r\n');
  }

  static Future<List<FileSystemEntity>> getLogFiles() {
    return FileUtils.getLocalDirFiles('logs');
  }
}
