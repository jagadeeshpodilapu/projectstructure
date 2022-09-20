import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:project_struct/presentation/views/homepage/user_model.dart';

final dataProvider = FutureProvider<List<UserModel>>((ref) async {
  return fetchPhotos();
});

List<UserModel> parsePhotos(String responseBody) {
  List list = json.decode(responseBody) as List<dynamic>;
  List<UserModel> photos =
      list.map((model) => UserModel.fromJson(model)).toList();
  return photos;
}

Future<List<UserModel>> fetchPhotos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (response.statusCode == 200) {
    return parsePhotos(response.body);
  } else {
    throw Exception();
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<UserModel>> viewModel = ref.watch(dataProvider);
    return Scaffold(
        appBar: AppBar(title: Text("API Fetch")),
        body: viewModel.when(
          loading: () => Center(child: const CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString())),
          data: (data) => ListView.builder(
              itemCount: 20,
              itemBuilder: (_, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(data[index].id.toString()),
                        const SizedBox(width: 10),
                        Text(data[index].thumbnailUrl.toString()),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}

/* 
viewModel.userModel.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: 20,
              itemBuilder: (_, index) {
                return const Card(
                  child: Text(""),
                );
              }), */