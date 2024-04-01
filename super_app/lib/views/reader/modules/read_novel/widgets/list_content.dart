part of '../view/read_novel_view.dart';

class ListContentController {
  _ListContentState? _state;

  ValueChanged<int>? onChangeIndex;

  ValueNotifier<int> scrollIndex = ValueNotifier(0);

  int get getCurrentIndex => scrollIndex.value;
  void _bind(_ListContentState? state) {
    _state = state;
  }

  void jumpTo(int index) {
    _state?._jumpTo(index);
    scrollIndex.value = index;
  }

  void _onChangeIndex(int index) {
    onChangeIndex?.call(index);
    scrollIndex.value = index;
  }

  void onSliderChangeValue(int index) {
    if (index == scrollIndex.value) return;
    jumpTo(index);
  }
}

class ListContent extends StatefulWidget {
  const ListContent(
      {super.key,
      required this.content,
      required this.controller,
      required this.initialScrollIndex});
  final String content;
  final ListContentController controller;
  final int initialScrollIndex;

  @override
  State<ListContent> createState() => _ListContentState();
}

class _ListContentState extends State<ListContent> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  int _currentIndex = 0;
  List<String> _contents = [];

  @override
  void initState() {
    widget.controller._bind(this);
    _contents = widget.content.split("\n");
    _itemPositionsListener.itemPositions.addListener(() {
      if (_itemPositionsListener.itemPositions.value.isEmpty) return;
      final index = _itemPositionsListener.itemPositions.value.last.index;
      if (_currentIndex != index) {
        _currentIndex = index;
        widget.controller._onChangeIndex(_currentIndex);
      }
    });
    super.initState();
  }

  void _jumpTo(int index) {
    _itemScrollController.jumpTo(index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ScrollablePositionedList.builder(
        itemCount: _contents.length,
        initialScrollIndex: widget.initialScrollIndex,
        itemBuilder: (context, index) => Text(_contents[index]),
        itemScrollController: _itemScrollController,
        scrollOffsetController: _scrollOffsetController,
        itemPositionsListener: _itemPositionsListener,
      ),
    );
  }
}
