import 'package:flutter/material.dart';
import 'package:uas/pages/home_page.dart';
import 'package:uas/pages/category_page.dart';

class DrawerNavigationPage extends StatefulWidget {
  const DrawerNavigationPage({super.key});

  @override
  State<DrawerNavigationPage> createState() => _DrawerNavigationPageState();
}

class _DrawerNavigationPageState extends State<DrawerNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://spng.pngfind.com/pngs/s/16-168087_wikipedia-user-icon-bynightsight-user-image-icon-png.png")),
              accountEmail: Text("wibistara@gmail.com"),
              accountName: Text("Helga Aka Wibistara"),
            ),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context, HomePage())),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text('Categories'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
