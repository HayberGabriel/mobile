import 'dart:async';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/admin_orders_manager.dart';
import 'package:lojavirtual/models/admin_users_manager.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUsersScreen extends StatelessWidget {
  final User user = User();

  Future<void> openPhone(String x) async {
    await launch('tel:${x}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                leading: IconButton(icon: Icon(Icons.phone),
                  iconSize: 28,
                  color: Colors.black,
                  onPressed: () {openPhone(adminUsersManager.users[index].telefone);},),
                title: Text(
                  adminUsersManager.users[index].name,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black),
                ),
                subtitle: Text(
                  '${adminUsersManager.users[index].email}}',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onLongPress: () {
                  openPhone(adminUsersManager.users[index].telefone);
                },
                onTap: () {
                  context
                      .read<AdminOrdersManager>()
                      .setUserFilter(adminUsersManager.users[index]);
                  context.read<PageManager>().setPage(6);
                },
              );
            },
            highlightTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
