import 'package:flutter/material.dart';
import 'package:thoughtx/src/home/app_barx.dart';
import 'package:thoughtx/src/home/home_contoller.dart';
import 'package:thoughtx/src/home/thought_item.dart';
import 'package:thoughtx/src/home/thoughx_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late ListModel<Thought> _list;

  final HomeController _homController = HomeController();

  @override
  void initState() {
    super.initState();
    _list = ListModel<Thought>(
      listKey: _listKey,
      initialItems: _homController.thoughts,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _insert(Thought thought) {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    _homController.addThought(content: thought.content);
    _list.insert(_list.length, thought);
  }

  void _remove(int index) {
    _homController.removeThought(index: index);
    _list.remove(index);
  }

  Widget _buildItem(context, index, animation) {
    return Dismissible(
      onDismissed: (direction) {
        _remove(index);
      },
      key: UniqueKey(),
      child: ThoughtItem(animation: animation, content: _list[index].content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _homController,
      builder: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const AppBarX(),
          Expanded(
              flex: 5,
              child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _list.length,
                  controller: _scrollController,
                  itemBuilder: _buildItem)),
          Expanded(
            flex: 1,
            child: Center(
              child: ThoughtxField(
                onFinished: (thought) {
                  _insert(Thought(content: thought));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListModel<E> {
  ListModel({
    required this.listKey,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;

  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E remove(int index) {
    final E removedItem = _items.removeAt(index);
    if (_animatedList != null) {
      _animatedList!.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        // Build the widget that will be animated out of the list
        return const SizedBox.shrink();
      });
    }

    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
