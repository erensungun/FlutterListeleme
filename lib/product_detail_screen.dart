import 'package:flutter/material.dart';
import 'model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductElement product;
  const ProductDetailScreen({super.key,required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            'Ürün Detayı',
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
              /*_quantity=0;*/
            },
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
                child: Column(
                  children: [
                    Image.network(
                      widget.product.images[0],
                      height: 300,
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.product.title,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              widget.product.category,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade500,
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                              vertical: 14),
                                          decoration: BoxDecoration(
                                            color:
                                            const Color(0xff6750a4),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                              "\$ ${widget.product.price}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white,
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Stok: ${widget.product.stock}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    widget.product.description,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15)),
                              ],
                            ),
                          )),
                    )
                  ],
                )
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16,),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )
              ),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(99)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:() => setState(() {
                            if(_quantity > 0){
                              _quantity--;
                            }
                          }),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.shade900,
                            child: const Icon(Icons.remove,color: Colors.white,),
                          ),
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap:() => setState(() {
                            _quantity++;
                          }),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.shade900,
                            child: const Icon(Icons.add,color: Colors.white),
                          ),
                        ),
                      ],),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey.shade900),
                          fixedSize: MaterialStateProperty.all(const Size(double.infinity, 65)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))
                      ),
                      child: const Text('Add to Cart',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          )),
                    ),
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







