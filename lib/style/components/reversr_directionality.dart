import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class APPReverseDirectionality extends StatelessWidget {
  final Widget child;
  final bool reverse;
  const APPReverseDirectionality(
      {super.key, required this.child, this.reverse = true});

  @override
  Widget build(BuildContext context) {
    return reverse
        ? Directionality(
            textDirection: navigatorKey.currentContext!.fallbackLocale
                    .toString()
                    .contains('ar')
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: child,
          )
        : child;
  }
}
