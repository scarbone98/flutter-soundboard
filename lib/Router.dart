import 'package:flutter/material.dart';
import 'pages/SoundBoardDetails.dart';
import 'pages/Home.dart';
import 'RouteArguments.dart';

class WidgetWrapper extends StatelessWidget {
  final Widget child;
  const WidgetWrapper({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: child),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => WidgetWrapper(child: HomePage()),
        );
      case '/soundboardDetails':
        final SoundBoardDetailsArguments args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => WidgetWrapper(
            child: SoundBoardDetails(
              pageTitle: args.soundBoardTitle,
              id: args.id,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => WidgetWrapper(child: HomePage()),
        );
    }
  }
}
