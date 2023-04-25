import 'package:anglara_ecommerce/ui/CartPage/cart_screen.dart';
import 'package:anglara_ecommerce/ui/Homepage/profil_screen.dart';
import 'package:anglara_ecommerce/ui/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../repository/cart_repository.dart';
import 'homepage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  int _cartItemCount = 0;

  User? _user;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CartScreen(),
    Profile_screen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _updateCartItemCount();
  }

  Future<void> _updateCartItemCount() async {
    final cartItems = await CartRepository().getCartItems();
    setState(() {
      _cartItemCount = cartItems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ANGLARA"),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(_user!.displayName ?? ''),
                accountEmail: Text(_user!.email ?? '')),
            ListTile(onTap: () {}, title: const Text("Electronics")),
            ListTile(onTap: () {}, title: const Text("Jewelery")),
            ListTile(onTap: () {}, title: const Text("Men's Clothing")),
            ListTile(onTap: () {}, title: const Text("Women's Clothing")),
            ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ));
                },
                title: const Text("Logout")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(cartItemCount: _cartItemCount,selectedIndex: _selectedIndex,onItemTapped: _onItemTapped),
      body: _selectedIndex == 1
          ? CartScreen(onItemRemoved: _updateCartItemCount)
          : _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class BottomNavigationWidget extends StatefulWidget {
  final int cartItemCount;
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BottomNavigationWidget(
      {Key? key, required this.cartItemCount, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeContent: Text(widget.cartItemCount.toString(),
                style: const TextStyle(fontSize: 10)),
            child: const Icon(Icons.shopping_cart),
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.red[800],
      onTap: widget.onItemTapped,
    );
  }
}

