import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thoughtx/src/home/app_barx.dart';
import 'package:thoughtx/src/home/home_contoller.dart';
import 'package:thoughtx/src/home/thought_item.dart';
import 'package:thoughtx/src/home/thoughts_screen.dart';
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

        body: SafeArea(
          child: HomeView(homeController: homeController),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
          ],
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    key: Key('$index+${homeController.thoughts[index]}'),
                    child: ThoughtItem(content: homeController.thoughts[index]),
                  );
                }),
              ),
            ),
            OutlinedButton(
                onPressed: () async {
                  final res = await homeController.generateTodo();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ThoughtsScreen(res: res);
                    },
                  ));
                },
                child: const Text('Generate Todo')),
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
    );
  }
}
