import 'package:flutter/material.dart';

class AppBarX extends StatelessWidget {
  const AppBarX({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 81,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bulb.png'))),
      child: Center(
          child: Text('Home',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.grey))),
    );
  }
}
