import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_challenge/api/user.dart';
import 'package:flutter_challenge/constants/theme.dart';
// import 'package:flutter_challenge/pages/Category/index.dart';
import 'package:flutter_challenge/pages/Chat/index.dart';
import 'package:flutter_challenge/pages/Home/index.dart';
import 'package:flutter_challenge/pages/Profile/index.dart';
import 'package:flutter_challenge/stores/TokenManager.dart';
import 'package:flutter_challenge/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Bottom navigation item configuration
  final List<Map<String, dynamic>> _navItems = [
    {
      "icon": Icons.home_outlined,
      "activeIcon": Icons.explore,
      "text": "Explore",
    },
    {
      "icon": Icons.chat_bubble_outline,
      "activeIcon": Icons.chat_bubble,
      "text": "Chat",
    },
    {
      "icon": Icons.person_outline,
      "activeIcon": Icons.person,
      "text": "Profile",
    },
  ];

  // Build bottom navigation bar items
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_navItems.length, (int index) {
      return BottomNavigationBarItem(
        icon: Icon(_navItems[index]["icon"]),
        activeIcon: Icon(_navItems[index]["activeIcon"]),
        label: _navItems[index]["text"],
      );
    });
  }

  // Pages corresponding to each tab
  List<Widget> _getChildren() {
    return [HomeView(), ChatView(), ProfileView()];
  }

  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = Get.find();

    // Delay user initialization to avoid startup issues
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _initUser();
      }
    });
  }

  Future<void> _initUser() async {
    try {
      await tokenManager.init();
      if (tokenManager.getToken().isNotEmpty) {
        _userController.updateUserInfo(await getUserInfoAPI());
      }
    } catch (e) {
      print("Failed to initialize user info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack to preserve page states
      body: IndexedStack(
        index: _currentIndex,
        children: _getChildren(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.black54,
        onTap: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }
}
