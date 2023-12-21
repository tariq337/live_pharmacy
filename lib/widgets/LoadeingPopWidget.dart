import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class LoadeingPopWidget extends StatefulWidget {
  Widget child;
  bool isLoadeing;
  String error;
  Function()? reloade;
  LoadeingPopWidget(
      {super.key,
      required this.child,
      required this.isLoadeing,
      this.error = "",
      this.reloade});

  @override
  State<LoadeingPopWidget> createState() => _LoadeingPopWidgetState();
}

class _LoadeingPopWidgetState extends State<LoadeingPopWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.error.isNotEmpty) {
      return Center(
        child: Column(
          children: [
            TextUnit.TextTitel(text: widget.error, color: Colors.redAccent),
            const SizedBox(
              height: 10,
            ),
            IconButton(
                onPressed: widget.reloade,
                icon: const Icon(
                  Icons.replay,
                  size: 52,
                  color: Colors.redAccent,
                ))
          ],
        ),
      );
    }
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: widget.child,
        ),
        if (widget.isLoadeing)
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black38.withOpacity(.5),
            child: const CircularProgressIndicator(),
          )
      ],
    );
  }
}
