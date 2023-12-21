import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Map<String, dynamic> cart;
  final VoidCallback onAdd, onReduce;
  const CartItem({
    Key? key,
    required this.cart,
    required this.onAdd,
    required this.onReduce,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      blurRadius: 4,
      offset: const Offset(0, 4),
      color: unitColor.NEUTRAL[3].withOpacity(.8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3 - 110,
        height: 100,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3 - 110,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: unitColor.NEUTRAL[3],
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(cart["imageUrl"], width: 50, height: 40),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.bottomCenter,
                            width: (MediaQuery.of(context).size.width * 0.3 -
                                    110) *
                                .7,
                            height: 50,
                            child: TextUnit.TextsubTitel(
                                text: cart["name"], maxLines: 2)),
                        const SizedBox(height: 5),
                        Container(
                            alignment: Alignment.bottomCenter,
                            width: (MediaQuery.of(context).size.width * 0.3 -
                                    110) *
                                .7,
                            height: 30,
                            child: TextUnit.TextsubTitel(
                                text: "${cart["price"]}", maxLines: 1)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onReduce,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: unitColor.bgColor.withOpacity(0.1)),
                          child: const Icon(
                            Icons.remove,
                            color: unitColor.bgColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextUnit.TextTitel(text: cart["number"].toString()),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: onAdd,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: unitColor.bgColor.withOpacity(0.1)),
                          child: const Icon(
                            Icons.add,
                            color: unitColor.bgColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
