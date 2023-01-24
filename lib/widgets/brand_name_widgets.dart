import 'package:flutter/material.dart';

Widget brandName(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Wallpaper',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 26,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              'Hub',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ],
    ),
  );
}
