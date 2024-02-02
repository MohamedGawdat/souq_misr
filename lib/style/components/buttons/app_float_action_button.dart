import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppFloatActionButton extends StatelessWidget {
  final Function onPress;
  final String title;
  const AppFloatActionButton(
      {super.key, required this.onPress, this.title = 'حفظ'});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // onPressed: _incrementCounter,
      // heroTag: 'tap3Tasks',
      onPressed: null,
      tooltip: title,

      extendedPadding: const EdgeInsets.all(0),
      elevation: 0,
      isExtended: true,
      label: SizedBox(
        width: 0.25.sw,
        height: 50,
        child: InkWell(
          // title: title,
          radius: 30,
          onTap: () async {
            await onPress();
          },
          // isMainColor: false,
          // showLoader: true,
        ),
      ),
    );
  }
}
