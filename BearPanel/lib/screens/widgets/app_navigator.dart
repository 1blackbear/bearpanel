import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  PageController controller;
  BottomNavigator({Key? key, required this.controller}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  void _onItemTapped(int index) {
    widget.controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Disciplinas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Estatísticas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: widget.controller.page?.round() ?? 0,
      selectedItemColor: Color(0xff363636),
      unselectedItemColor: Color(0xFF4e4e4e),
      onTap: _onItemTapped,
      showUnselectedLabels: false,
      iconSize: 28,
    );
  }
}



