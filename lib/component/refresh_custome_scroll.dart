import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///SmartRefresher 上下拉刷新
class RefreshCustomeScroll extends StatelessWidget {
  RefreshCustomeScroll({Key key, @required this.child, this.refresh, this.loadMore})
      : super(key: key);
  final RefreshController _refreshController = RefreshController();
  final Widget child;
  final Function refresh;
  final Function loadMore;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: () {
        if (refresh != null && refresh is Function) {
          refresh(_refreshController);
        } else {
          _refreshController.refreshCompleted();
        }
      },
      onLoading: () {
        if (loadMore != null && loadMore is Function) {
          loadMore(_refreshController);
        } else {
          _refreshController.loadComplete();
        }
      },
      header: MaterialClassicHeader(distance: 40),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
      ),
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      child: child,
    );
  }
}
