import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:shopipi_mobile_v2/models/user.dart';
import 'package:shopipi_mobile_v2/provider/authProvider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isAuthenticated = authProvider.isAuthenticated;
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(title: Text('Account'), actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
      ]),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildProfileHeader(isAuthenticated, user),
        ]),
      ),
    );
    // bottomNavigationBar: Navbar(current: 3, onTap: (index) {}),
  }

  Widget _buildProfileHeader(bool isAuthenticated, User user) {
    return Container(
      color: Colors.white,
      child: GFListTile(
        avatar: GFAvatar(
          backgroundImage: NetworkImage(user.image ?? ''),
        ),
        title:
            Text(isAuthenticated ? user.name : 'Chào mừng bạn đến với Shopipi'),
        subTitle: isAuthenticated
            ? Text(user.email)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GFButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    text: 'Đăng nhập',
                    type: GFButtonType.transparent,
                    size: GFSize.SMALL,
                    shape: GFButtonShape.square,
                    fullWidthButton: false,
                  ),
                  const Text('/', style: TextStyle(color: Colors.grey)),
                  GFButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    text: 'Đăng ký',
                    type: GFButtonType.transparent,
                    size: GFSize.SMALL,
                    shape: GFButtonShape.pills,
                    fullWidthButton: false,
                  ),
                ],
              ),
        // onTap: () {},
      ),
    );
  }
}
