import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'hoge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum MyMenuOption {
  home, profile, settings;
  String get name {
    switch (this) {
      case home:
        return 'Home';
      case profile:
        return 'Profile';
      case settings:
        return 'Settings';
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  MyMenuOption? _selectedOption;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton(
              onSelected: (option) {
                setState(() {
                  _selectedOption = option;
                });
              },
              itemBuilder: (context) => MyMenuOption.values.map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(
                    option.name,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
              padding: EdgeInsets.zero,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu,
                    size: 24,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  final RenderBox? box = context.findRenderObject() as RenderBox?;
                  final Offset? offset = box?.localToGlobal(Offset.zero);
                  print('***** offset.dx: ${offset?.dx} offset.dy: ${offset?.dy}');
                  final mediaQuery = MediaQuery.of(context);
                  print('***** mediaQuery.size.width ${mediaQuery.size.width}, mediaQuery.size.height: ${mediaQuery.size.height}');
                  final RelativeRect position = RelativeRect.fromLTRB(
                    offset!.dx,
                    offset.dy,
                    mediaQuery.size.width - offset.dx,
                    mediaQuery.size.height - offset.dy,
                  );
                  final MyMenuOption? selectedOption = await showMenu(
                    context: context,
                    position: position,
                    items: MyMenuOption.values.map((option) {
                      return PopupMenuItem(
                        value: option,
                        child: Text(
                          option.name,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                  setState(() {
                    _selectedOption = selectedOption;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 24,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedOption?.name ?? 'Not selected',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}