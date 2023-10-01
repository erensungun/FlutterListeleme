import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:http/http.dart' as http;
import 'package:listelemeuygulamasi/model.dart';
import 'package:listelemeuygulamasi/product_detail_screen.dart';

import 'login_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with SingleTickerProviderStateMixin{
  final url = Uri.parse('https://dummyjson.com/products');
  int counter = 0;
  var dataResults;
  bool isLoading = true;

  late Animation<double> _animation;
  late AnimationController _animationController;

  void callData() async {
    print("Calldata çağırıldı");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = productFromJson(response.body);
        if (mounted) {
          setState(() {
            counter = result.products.length;
            dataResults = result;
            isLoading = false;
          });
        }
      } else {
        print('if hatası yakalandı');
        print(response.statusCode);
      }
    } catch (e) {
      print('Try catch hatası yakalandı');
      print(e.toString());
    }
  }
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
    callData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff6750a4),
        title: const Text('Listeleme Uygulaması'),
        titleTextStyle:const TextStyle(color: Colors.white,fontSize: 20),
      ),
      body: isLoading
          ? const Center(
            child: CircularProgressIndicator(),
            )
            : Center(
              child: ListView.builder(
              padding: const EdgeInsets.only(left: 12, top: 12, bottom: 16, right: 0),
              itemCount: counter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataResults.products[index].title),
                  subtitle: Text(
                    dataResults.products[index].description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                    NetworkImage(dataResults.products[index].thumbnail),
                  ),
                  trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          dataResults.products.removeAt(index);
                        });
                      }
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ProductDetailScreen(product: dataResults.products[index]);
                      }),
                    );
                  },
                );
              }
            ),
        ),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
              icon: Icons.refresh,
              iconColor: Colors.white,
              title: 'Yeniden Yükle',
              titleStyle: const TextStyle(fontSize: 16,color: Colors.white),
              bubbleColor: const Color(0xff6750a4),
              onPress: () {
                setState(() {
                  isLoading = true;
                });
                callData();
                _animationController.reverse();
              },
          ),
          Bubble(
            icon: Icons.exit_to_app,
            iconColor: Colors.white,
            title: 'Çıkış Yap',
            titleStyle: const TextStyle(fontSize: 16,color: Colors.white),
            bubbleColor: const Color(0xff6750a4),
            onPress: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('Çıkış'),
                  content: const Text('Çıkış yapmak istediğinize emin misiniz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                          )
                        )},
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              _animationController.reverse();
            }
          )

        ],
        iconColor: Colors.white,
        animatedIconData: AnimatedIcons.menu_close,
        backGroundColor: const Color(0xff6750a4),
        animation: _animation,
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),
      ),
    );
  }

}