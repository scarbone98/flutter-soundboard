import 'package:flutter/material.dart';
import 'pages/SoundBoardDetails.dart';
import 'pages/Home.dart';
import 'RouteArguments.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class WidgetWrapper extends StatelessWidget {
  final Widget child;
  final String pageTitle;
  final bool bottomBar;
  const WidgetWrapper(
      {Key key, @required this.child, this.bottomBar = false, this.pageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar ? BottomBar() : null,
      body: SafeArea(
        child: child,
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  BottomBar({Key key}) : super(key: key);

  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<BottomNavigationBarItem> navigationTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
    BottomNavigationBarItem(
        icon: Icon(Icons.surround_sound), title: Text('Boards')),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), title: Text('Settings')),
  ];

  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (int selectedIndex) {
          setState(() {
            _selectedIndex = selectedIndex;
          });
        },
        currentIndex: _selectedIndex,
        items: navigationTabs);
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => WidgetWrapper(
            child: HomePage(),
            bottomBar: true,
            pageTitle: 'Soundboards',
          ),
        );
      case '/soundboardDetails':
        final SoundBoardDetailsArguments args = settings.arguments;
        return SlideRightRoute(
          page: WidgetWrapper(
            child: SoundBoardDetails(
              pageTitle: args.soundBoardTitle,
              id: args.id,
            ),
            pageTitle: args.soundBoardTitle,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => WidgetWrapper(child: HomePage()),
        );
    }
  }
}
