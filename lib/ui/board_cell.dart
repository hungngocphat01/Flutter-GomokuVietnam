import 'package:gomoku/ui/game_board.dart';
import 'package:flutter/material.dart';
import 'package:gomoku/util/enum.dart';
import 'package:gomoku/globals.dart' as globals;

class BoardCell extends StatefulWidget {
  final int _rowpos;
  final int _colpos;
  final double _size;
  var isMarked = ValueNotifier<bool>(false);
  bool isActive = false;

  BoardCell(this._rowpos, this._colpos, this._size, {Key? key})
      : super(key: key);

  @override
  _BoardCellState createState() => _BoardCellState();
}

class _BoardCellState extends State<BoardCell> {
  Icon? _activeIcon;

  void onUserClick(BuildContext context) {
    if (widget.isActive) return;

    final parentCbSt = Gameboard.of(context);
    if (parentCbSt != null) {
      widget.isActive = true;
      var player = parentCbSt.handleUserClick(widget._rowpos, widget._colpos);
      setState(() {
        // Player 1
        if (player == Player.player1) {
          _activeIcon = globals.p1Icon;
        } else {
          _activeIcon = globals.p2Icon;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onUserClick(context),
      child: ValueListenableBuilder(
        valueListenable: widget.isMarked,
        builder: (context, value, child) => Container(
          width: widget._size,
          height: widget._size,
          decoration: BoxDecoration(
            color: widget.isMarked.value
                ? Colors.greenAccent[100]
                : Colors.lime[50],
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: _activeIcon,
        ),
      ),
    );
  }
}