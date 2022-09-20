import 'package:flutter/material.dart';
import 'package:project_struct/presentation/providers/data_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DataProvider>(context,listen: false).getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (contex, index) {
              return Text('index is $index');
            }),
      ),
    );
  }
}
