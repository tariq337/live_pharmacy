import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final bool api;
  const ProductItem(
      {Key? key,
      required this.name,
      required this.price,
      required this.image,
      this.api = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: unitColor.NEUTRAL[4],
        //  border: Border.all(color: Colors.black26)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextUnit.TextsubTitel(text: name, maxLines: 2),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: api
                      ? Image.network(
                          UrlData.imageUrl(image),
                          errorBuilder: (context, error, _) => const Icon(
                            Icons.image_not_supported_outlined,
                            size: 32,
                          ),
                        )
                      : Image.asset(
                          image,
                          errorBuilder: (context, error, _) => const Icon(
                            Icons.image_not_supported_outlined,
                            size: 32,
                          ),
                        ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: TextUnit.TextsubTitel(
              text: "SD $price",
            ),
          )
        ],
      ),
    );
  }
}
