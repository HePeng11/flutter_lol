import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hp_demo1/common/fileUtil.dart';
import 'package:hp_demo1/common/logUtil.dart';

class LogView extends StatefulWidget {
  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text('logs'),
      ),
      body: FutureBuilder(
        future: LogUtil.getLogFiles(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitChasingDots(
                color: Colors.blueAccent,
              ),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext ctx, int index) => new Divider(),
              itemBuilder: (BuildContext buildContext, int index) {
                return GestureDetector(
                  onTap: () {
                    FileUtils.readFile(snapshot.data[index].path).then((_) {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return TxtView(_, snapshot.data[index].path);
                      }));
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Text(
                            snapshot.data[index].path.replaceFirst(
                                '${snapshot.data[index].parent.path}/', ''),
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(Icons.keyboard_arrow_right),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TxtView extends StatelessWidget {
  TxtView(this.str, this.filePath);
  final TextEditingController controller = new TextEditingController();
  final String str;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    controller.text = str;
    return Scaffold(
      appBar: AppBar(
        title: Text('log'),
        actions: <Widget>[
          RawMaterialButton(
            child: Icon(Icons.delete_outline),
            highlightColor: Colors.teal[100],
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          'confirm',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        content: Text(
                          '确定清空该日志吗?',
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          FlatButton(
                            child: Text('确定'),
                            onPressed: () {
                              FileUtils.writeFile(filePath, '',
                                  isFullName: true, mode: FileMode.write);
                              controller.text = '';
                              Navigator.pop(context, true);
                            },
                          ),
                        ],
                      ));
            },
          )
        ],
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        child: TextField(
          controller: controller,
          readOnly: true,
          maxLines: str.length < 15 ? 1 : str.length ~/ 15,
          decoration:
              InputDecoration(hintText: '暂无数据', border: InputBorder.none),
        ),
      )),
    );
  }
}
