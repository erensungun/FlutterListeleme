import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final url = Uri.parse('https://dummyjson.com/products');
  int counter = 0;
  var dataResults;
  bool isLoading = true;

  Future callData() async {
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
        return result;
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
    super.initState();
    callData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.title),
      ),
      body: isLoading
      ? Center(
        child: CircularProgressIndicator(),
      )
      : Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
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
                  icon: Icon(Icons.close),
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
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.orange,
        onPressed: () {
          setState(() {
            isLoading = true; // Yeniden veri çağrısına başladığınızda isLoading'u true yapın.
          });
          callData();
        },
      ),
    );
  }
}

*/