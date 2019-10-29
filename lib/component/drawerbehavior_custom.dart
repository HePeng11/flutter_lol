import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

class DrawerbehaviorCustom extends StatelessWidget {
  DrawerbehaviorCustom(this.child, {Key key, this.title='',this.actions}) : super(key: key);
  final Widget child;
  final List<Widget> actions;
  final String title;
  final String selectedMenuItemId = '1';

  final menu = new Menu(
    items: [
      new MenuItem(
        id: '1',
        title: 'THE PADDOCK',
        icon: Icons.fastfood,
      ),
      new MenuItem(
        id: '2',
        title: 'THE HERO',
        icon: Icons.person,
      ),
      new MenuItem(
        id: '3',
        title: 'HELP US GROW',
        icon: Icons.terrain,
      ),
      new MenuItem(
        id: '4',
        title: 'SETTINGS',
        icon: Icons.settings,
      ),
    ],
  );


  Widget headerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://avatars3.githubusercontent.com/u/23466980?s=400&u=fcfd3a4ffacc3fd7e3a6b9a976d1b2dc0a324a21&v=4")))),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "hepeng",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "91453542@qq.com",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DrawerScaffold(
      percentage: 1,
      cornerRadius: 0,
      appBar: AppBarProps(
          title: Text(title),
          actions: actions),
      menuView: new MenuView(
        menu: menu,
        headerView: headerView(context),
        animation: false,
        alignment: Alignment.topLeft,
        color: Theme.of(context).primaryColor,
        // selectedItemId: selectedMenuItemId,
        // itemBuilder:
        //     (BuildContext context, MenuItem menuItem, bool isSelected) {
        //   return Container(
        //     color: isSelected
        //         ? Theme.of(context).accentColor.withOpacity(0.7)
        //         : Colors.transparent,
        //     padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        //     child: Text(
        //       menuItem.title,
        //       style: Theme.of(context).textTheme.subhead.copyWith(
        //           color: isSelected ? Colors.black87 : Colors.white70),
        //     ),
        //   );
        // },
        onMenuItemSelected: (String itemId) {
          // selectedMenuItemId = itemId;
          // todo
        },
      ),
      contentView: Screen(
        contentBuilder: (context) =>child,
      ),
    );
  }
}
