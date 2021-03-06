import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class InformationTabMenu extends StatefulWidget {
  final Function callback;
  final List<dynamic> list;

  const InformationTabMenu({Key key, this.callback,  @required this.list}) : super(key: key);
  @override
  _InformationTabMenuState createState() => _InformationTabMenuState();
}

class _InformationTabMenuState extends State<InformationTabMenu> {
  int active = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.list.length,
      itemBuilder: (ctx, id) {
        return GestureDetector(
          onTap: () {
            widget.callback(id);
            setState(() {
              active = id;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                Text(
                  "${widget.list[id]}",
                  style: TextStyle(
                    fontWeight:
                    active == id ? FontWeight.bold : FontWeight.normal,
                    color: active == id ? Colors.black : Colors.grey[500],
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
                active == id ? Container(
                  width: 30,
                  height: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: HexColor('#C61818'),
                  ),
                ) : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}