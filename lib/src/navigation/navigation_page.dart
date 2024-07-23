import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:thoughtx/src/home/home_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    super.key,
  });

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int _selectedPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _selectedPage = value;
          });
        },
        children: const [
          HomePage(),
          Center(
            child: Text('Proile Page'),
          ),
          Center(
            child: Text('Settings Page'),
          ),
        ],
      )),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedPage,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceIn);
          setState(() {
            _selectedPage = index;
          });
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        duration: const Duration(milliseconds: 500),
        backgroundColor: const Color.fromARGB(32, 100, 100, 100),
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined), title: const Text('Home')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.person_2_outlined),
              title: const Text('Profile')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.settings_outlined),
              title: const Text('Settings')),
        ],
      ),
    );
  }
}
