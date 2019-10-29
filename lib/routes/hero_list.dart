import 'package:dropdown_menu/_src/drapdown_common.dart';
import 'package:dropdown_menu/_src/dropdown_header.dart';
import 'package:dropdown_menu/_src/dropdown_list_menu.dart';
import 'package:dropdown_menu/_src/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:hp_demo1/component/hero_card.dart';
import 'package:hp_demo1/component/hero_card_falls.dart';
import 'package:hp_demo1/component/search_title.dart';
import 'package:hp_demo1/services/homeService.dart';
import '../models/heros_info.dart' as model;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dropdown_menu/_src/dropdown_templates.dart';

class HerosView extends StatefulWidget {
  @override
  _HerosViewState createState() => _HerosViewState();
}

class _HerosViewState extends State<HerosView> {
  List<model.Hero> heros = new List<model.Hero>();
  List<model.Hero> allHeros = new List<model.Hero>();
  HomeService homeService = new HomeService();
  bool isFallsView = false;
  ScrollController scrollController;
  ScrollController scrollController2;
  bool showToTopBtn = false;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    homeService.localService.getHero().then((result) {
      if (result.hero != null && result.hero.length > 0) {
        setState(() {
          heros = result.hero;
          allHeros = result.hero;
        });
      }
    });
    homeService.getHeros(context).then((result) {
      if (result.hero != null && result.hero.length > 0) {
        setState(() {
          heros = result.hero;
          allHeros = result.hero;
        });
      }
    });
    _convertScrollController(init: true);
    super.initState();
  }

  ///controller1->controller2
  void _convertScrollController({bool init = false}) {
    if (isFallsView) {
      scrollController2 =
          new ScrollController(initialScrollOffset: scrollController.offset);
      scrollController.dispose();
      _addListener(scrollController2);
    } else {
      if (init) {
        scrollController = new ScrollController();
      } else {
        scrollController =
            new ScrollController(initialScrollOffset: scrollController2.offset);
        scrollController2.dispose();
      }
      _addListener(scrollController);
    }
  }

  void _addListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchTitle(
          textEditingController: textEditingController,
          onChanged: (str) {
            setState(() {
              filterHeros();
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isFallsView = !isFallsView;
                _convertScrollController();
              });
            },
            color: Theme.of(context).buttonColor,
            splashColor: Colors.teal[300],
            icon: isFallsView ? Icon(Icons.reorder) : Icon(Icons.view_module),
            padding: EdgeInsets.only(right: 20, left: 20),
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              heroTag: 'HerosView_floatBtn',
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执行动画
                if (isFallsView) {
                  scrollController2.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                } else {
                  scrollController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }
              }),
    );
  }

  @override
  void dispose() {
    if (isFallsView) {
      scrollController2.dispose();
    } else {
      scrollController.dispose();
    }
    super.dispose();
  }

  ///过滤并排序数据
  void filterHeros() {
    heros = allHeros
        .where((f) =>
            heroTypeIndex == 0 ||
            f.roles.contains(hero_types_value[heroTypeIndex]))
        .where((f) =>
            textEditingController.text.isEmpty ||
            f.name.contains(textEditingController.text) ||
            f.alias
                .toLowerCase()
                .contains(textEditingController.text.toLowerCase()))
        .toList();
    switch (heroOderIndex) {
      case 1:
        heros
            .sort((a, b) => int.parse(a.attack).compareTo(int.parse(b.attack)));
        break;
      case 2:
        heros.sort(
            (a, b) => int.parse(a.defense).compareTo(int.parse(b.defense)));
        break;
      case 3:
        heros.sort((a, b) => int.parse(a.magic).compareTo(int.parse(b.magic)));
        break;
      case 4:
        heros.sort((a, b) =>
            int.parse(a.difficulty).compareTo(int.parse(b.difficulty)));
        break;
      default:
        break;
    }
    if (heroOderIndex > 0) {
      heros = heros.reversed.toList();
    }
  }

  ///scaffold body
  Widget _buildBody() {
    return DefaultDropdownMenuController(
        onSelected: ({int menuIndex, int index, int subIndex, dynamic data}) {
          switch (menuIndex) {
            case 0:
              if (index != heroTypeIndex) {
                heroTypeIndex = index;
                setState(() {
                  filterHeros();
                });
              }
              break;
            case 1:
              if (index != heroOderIndex) {
                heroOderIndex = index;
                setState(() {
                  filterHeros();
                });
              }
              break;
            default:
          }
        },
        child: Column(
          children: <Widget>[
            _buildDropdownHeader(),
            Expanded(
                child: Stack(
              children: <Widget>[_buildList(), _buildDropdownMenu()],
            ))
          ],
        ));
  }

  int heroTypeIndex = 0;
  int heroOderIndex = 0;

  ///下拉菜单头部
  DropdownHeader _buildDropdownHeader() {
    return new DropdownHeader(
      titles: [hero_types[heroTypeIndex], hero_oder_names[heroOderIndex]],
    );
  }

  ///下拉菜单内容
  DropdownMenu _buildDropdownMenu() {
    return new DropdownMenu(maxMenuHeight: kDropdownMenuItemHeight * 10,
        //  activeIndex: activeIndex,
        menus: [
          new DropdownMenuBuilder(
              builder: (BuildContext context) {
                return new DropdownListMenu(
                  selectedIndex: heroTypeIndex,
                  data: hero_types,
                  itemBuilder: buildCheckItem,
                );
              },
              height: kDropdownMenuItemHeight * hero_types.length),
          new DropdownMenuBuilder(
              builder: (BuildContext context) {
                return new DropdownListMenu(
                  selectedIndex: heroOderIndex,
                  data: hero_oder_names,
                  itemBuilder: buildCheckItem,
                );
              },
              height: kDropdownMenuItemHeight * hero_oder_names.length)
        ]);
  }

  ///数据部分
  Widget _buildList() {
    if (!isFallsView) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return HeroCard(
            hero: heros[index],
            no: index + 1,
            onTap: (_) {
              unfocus();
            },
          );
        },
        itemCount: heros.length,
        controller: scrollController,
      );
    } else {
      return new StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: heros.length,
        itemBuilder: (BuildContext context, int index) => new HeroCardFalls(
          hero: heros[index],
          no: index + 1,
          onTap: (_) {
            unfocus();
          },
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(1, index.isEven ? 1.4 : 1.4),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        controller: scrollController2,
      );
    }
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
    // FocusScope.of(context).requestFocus(FocusNode());
  }
}

const List<Map<String, dynamic>> hero_types = [
  {"title": "所有英雄"},
  {"title": "战士"},
  {"title": "法师"},
  {"title": "刺客"},
  {"title": "坦克"},
  {"title": "射手"},
  {"title": "辅助"},
];
const List<String> hero_types_value = [
  "",
  "fighter",
  "mage",
  "assassin",
  "tank",
  "marksman",
  "support",
];

const List<Map<String, dynamic>> hero_oder_names = [
  {"title": "排序方式"},
  {"title": "攻击力"},
  {"title": "防御"},
  {"title": "法术"},
  {"title": "难度"},
];
