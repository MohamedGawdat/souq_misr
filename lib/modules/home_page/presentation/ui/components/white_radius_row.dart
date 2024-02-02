import 'package:flutter/material.dart';

class WhiteRadiusRow extends StatelessWidget {
  const WhiteRadiusRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3ab081),
      height: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xffF8F8F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
