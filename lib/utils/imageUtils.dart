import 'package:flutter/material.dart';

class ImageUtils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Image getImg(String name, {String format: 'png'}) {
    return Image.asset('assets/images/$name.$format');
  }

}
