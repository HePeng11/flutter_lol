import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTitle extends StatelessWidget {
  SearchTitle(
      {@required this.textEditingController, this.onSubmitted, this.onChanged});
  final TextEditingController textEditingController;
  final Function onSubmitted;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: ScreenUtil.instance.setHeight(80)),
      decoration: BoxDecoration(
          color: Colors.teal[100], borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(ScreenUtil.instance.setHeight(15)),
      child: Container(
        child: TextField(
          // autofocus: true,
          decoration: new InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              icon: Icon(
                Icons.search,
              ),
              hintText: 'Please search'),
          controller: textEditingController,
          onSubmitted: (str) {
            if (onSubmitted != null) {
              onSubmitted(str);
            }
          },
          onChanged: (str) {
            if (onChanged != null) {
              onChanged(str);
            }
          },
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
