import 'package:flutter/material.dart';
import '../bloc/countBloc.dart';

class Book extends StatelessWidget {
  @override
  StatelessElement createElement() {
    print('book element');
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getCountBloc(context);
    print('bookbuild');
    return StreamBuilder<int>(
        stream: bloc.stream,
        initialData: bloc.count,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Scaffold(
            appBar: new AppBar(
              title: new Text('Book'),
            ),
            body: Stack(
              children: <Widget>[
                Text(
                  '${snapshot.data} times',
                  style: Theme.of(context).textTheme.display1,
                ),
                //由于StreamBuilder会导致scaffold自带的FloatingActionButton刷新 不想要刷新效果所以这样写
                new Container(
                  alignment: Alignment.bottomRight,
                  child: new Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 16, 16),
                    child: FloatingActionButton(
                      heroTag: 'book_float_btn',
                      key: UniqueKey(),
                      onPressed: () => bloc.increment(),
                      child: Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
