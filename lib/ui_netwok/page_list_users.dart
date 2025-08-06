import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_5/model/model_users.dart';
import 'package:task_5/ui_netwok/page_users_detail.dart';

class PageListUsers extends StatefulWidget {
  const PageListUsers({super.key});

  @override
  State<PageListUsers> createState() => _PageListUsersState();
}

class _PageListUsersState extends State<PageListUsers> {
  bool isLoading = true;
  List<ModelUsers> listUsers = [];

  bool isSearch = true;

  Future getUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
      );
      var data = jsonDecode(res.body);
      setState(() {
        for (Map<String, dynamic> item in data) {
          listUsers.add(ModelUsers.fromJson(item));
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  TextEditingController etSearch = TextEditingController();

  _PageListUsersState() {
    etSearch.addListener(() {
      setState(() {
        String keyword = etSearch.text.toLowerCase();
        if (keyword.isEmpty) {
          isSearch = false;
          etSearch.text = "";
        } else {
          isSearch = true;
          listUsers = listUsers
              .where((item) => item.name.toLowerCase().contains(keyword))
              .toList();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("List Users API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: etSearch,
              decoration: InputDecoration(
                hintText: "Search Data List",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.green.withOpacity(0.1),
              ),
            ),
            isSearch
                ? HasilSearch()
                : Expanded(
                    child: ListView.builder(
                      itemCount: listUsers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PageUsersDetail(listUsers[index]),
                                ),
                              );
                            },
                            title: Text(
                              listUsers[index].name ?? "Empty",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(listUsers[index].username),
                                Text(listUsers[index].email),
                                Text(listUsers[index].phone),
                                Text(listUsers[index].website),
                                Divider(),
                                Text(
                                  "Address:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(listUsers[index].address.street),
                                Text(listUsers[index].address.city),
                                Text(listUsers[index].address.zipcode),
                                Divider(),
                                Text(
                                  "Company:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(listUsers[index].company.name),
                                Text(listUsers[index].company.catchPhrase),
                              ],

                              // Task
                              // 1. ketika diklik bisa pindah ke detail
                              // 2. search di dalam list, tanpa menggunakan API
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget HasilSearch() {
    return Expanded(
      child: ListView.builder(
        itemCount: listUsers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PageUsersDetail(listUsers[index]),
                  ),
                );
              },
              title: Text(
                listUsers[index].name ?? "Empty",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(listUsers[index].username),
                  Text(listUsers[index].email),
                  Text(listUsers[index].phone),
                  Text(listUsers[index].website),
                  Divider(),
                  Text(
                    "Address:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(listUsers[index].address.street),
                  Text(listUsers[index].address.city),
                  Text(listUsers[index].address.zipcode),
                  Divider(),
                  Text(
                    "Company:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(listUsers[index].company.name),
                  Text(listUsers[index].company.catchPhrase),
                ],

                // Task
                // 1. ketika diklik bisa pindah ke detail
                // 2. search di dalam list, tanpa menggunakan API
              ),
            ),
          );
        },
      ),
    );
  }
}
