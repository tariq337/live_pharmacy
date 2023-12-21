import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/ProductItem.dart';
import 'package:flutter/material.dart';
import '../../model/ProductModel.dart';

class OrderBody extends StatefulWidget {
  List<Details> listOrderProdact;
  Function(Map<String, dynamic>) AddtoCardItem;
  OrderBody({
    super.key,
    required this.listOrderProdact,
    required this.AddtoCardItem,
  });

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: unitColor.NEUTRAL[3],
        borderRadius: BorderRadius.circular(7),
      ),
      child: widget.listOrderProdact.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              itemCount: (widget.listOrderProdact).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .8,
              ),
              itemBuilder: (BuildContext context, index) {
                Details produc = widget.listOrderProdact[index];

                return InkWell(
                  onTap: () {
                    widget.AddtoCardItem({
                      "id": produc.id,
                      "name": produc.name,
                      "price": produc.price,
                      "number": 0,
                      "imageUrl": produc.imageUrl
                    });
                  },
                  child: ProductItem(
                    name: produc.name ?? "",
                    image: produc.imageUrl ?? "",
                    price: produc.price ?? 0,
                  ),
                );
              })
          : const Center(
              child: Icon(
                Icons.grid_off_outlined,
                size: 55,
                color: Colors.black38,
              ),
            ),
    );
  }
}
