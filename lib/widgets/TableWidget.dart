import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  List<String> titel;
  List<List<Widget>> data;
  Function(int) onTopRow;
  bool? isObj;
  TableWidget(
      {super.key,
      this.isObj,
      required this.titel,
      required this.data,
      required this.onTopRow});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.titel.length, (index) {
            return Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width / 5) - 32,
              child: TextUnit.Textspcfic(
                  text: widget.titel[index].toString(),
                  maxLines: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  size: 15),
            );
          }),
        ),
        const Divider(),
        for (int i = 0; i < widget.data.length; i++)
          dataTable(
              data: widget.data,
              onTopRow: widget.onTopRow,
              titel: widget.titel,
              i: i)
      ],
    );
  }
}

class dataTable extends StatefulWidget {
  List<String> titel;
  List<List<Widget>> data;
  Function(int) onTopRow;
  int i;
  dataTable(
      {super.key,
      required this.data,
      required this.onTopRow,
      required this.titel,
      required this.i});

  @override
  State<dataTable> createState() => _dataTableState();
}

class _dataTableState extends State<dataTable> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onHover: (v) {
            setState(() {
              hover = v;
            });
          },
          onTap: () {
            widget.onTopRow(widget.i);
          },
          child: Container(
            color: hover ? (unitColor.NEUTRAL[2]).withOpacity(.2) : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.titel.length, (index) {
                return Container(
                    width: (MediaQuery.of(context).size.width / 5) - 32,
                    height: 80,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: hover ? 10 : 5),
                    child: widget.data[widget.i][index]);
              }),
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
