import 'package:flutter/material.dart';
import 'package:task_5/model/model_users.dart';

class PageUsersDetail extends StatelessWidget {
  final ModelUsers listUser;

  const PageUsersDetail(this.listUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          listUser.name,
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Username: ${listUser.username}"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Email: ${listUser.email}"),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Phone: ${listUser.phone}"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Website: ${listUser.website}"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              "Address:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text(listUser.address.street),
            Text(listUser.address.city),
            Text(listUser.address.zipcode),
            SizedBox(height: 8.0),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              "Company:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text(listUser.company.name),
            Text(listUser.company.catchPhrase),
            Text(listUser.company.bs),
          ],
        ),
      ),
    );
  }
}
