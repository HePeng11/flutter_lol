import 'package:flutter/material.dart';

class FadeInAnimationCustom extends StatefulWidget {
  FadeInAnimationCustom(this.child, {Key key}) : super(key: key);
  final Widget child;
  @override
  _FadeInAnimationCustomState createState() => _FadeInAnimationCustomState();
}

class _FadeInAnimationCustomState extends State<FadeInAnimationCustom>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2, milliseconds: 50));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return SafeArea(
          child: Transform(
            transform:
                Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
