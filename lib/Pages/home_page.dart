import 'package:flutter/material.dart';
import 'package:reportes/Pages/Feedback/feedback_page.dart';
import 'package:reportes/Pages/Location/location_page.dart';
import 'package:reportes/Pages/Report/report_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [ReportPage(), LocationPage(), FeedBackPage()];
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Ubicación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Sugerencias',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
