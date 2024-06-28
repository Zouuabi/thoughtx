import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thoughtx/src/home/home_contoller.dart';
import 'package:thoughtx/src/home/thought_item.dart';
import 'package:thoughtx/src/home/thoughx_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: homeController,
      builder: (context, child) => Scaffold(
        // appBar: PreferredSize(
        //   child: AppBarX(),
        //   preferredSize: Size(MediaQuery.sizeOf(context).width * 0.7, 81),
        // ),

        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/background.svg',
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                const AppBarX(),
                Expanded(
                  flex: 4,
                  child: ListView(
                    children:
                        List.generate(homeController.thoughts.length, (index) {
                      return Dismissible(
                        onDismissed: (direction) {
                          homeController.removeThought(index: index);
                        },
                        key: Key(
                            '$index+${homeController.thoughts[index].content}'),
                        child: ThoughtItem(
                            content: homeController.thoughts[index].content),
                      );
                    }),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ThoughtxField(
                    onFinished: (thought) {
                      homeController.addThought(content: thought);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarX extends StatelessWidget {
  const AppBarX({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 81,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 20),
            spreadRadius: 10,
            color: Colors.teal,
            blurRadius: 150)
      ], image: DecorationImage(image: AssetImage('assets/images/bulb.png'))),
      child: Center(
          child: Text('Home',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.grey))),
    );
  }
}
