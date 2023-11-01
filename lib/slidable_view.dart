import 'package:flutter/material.dart';

class SlidableViewMenuOption {
  final IconData icon;
  final String title;
  final void Function() onTap;
  SlidableViewMenuOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class SlidableView extends StatefulWidget {
  final Widget child;
  final List<SlidableViewMenuOption> menuOptions;
  const SlidableView({
    required this.child,
    required this.menuOptions,
    Key? key,
  }) : super(key: key);
  @override
  State<SlidableView> createState() => _SlidableViewState();
}

class _SlidableViewState extends State<SlidableView> with SingleTickerProviderStateMixin {
  static const double _menuOptionWidth = 72.0;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxWidth = constraint.maxWidth;
        final animation = Tween(
          begin: const Offset(0.0, 0.0),
          end: Offset(-((_menuOptionWidth * widget.menuOptions.length) / maxWidth), 0.0),
        ).animate(CurveTween(curve: Curves.decelerate).animate(_controller));

        return GestureDetector(
          onHorizontalDragUpdate: (data) {
            if (data.primaryDelta == null) return;
            _controller.value += (-data.primaryDelta! / (_menuOptionWidth * widget.menuOptions.length));
          },
          onHorizontalDragEnd: (data) {
            final primaryVelocity = data.primaryVelocity;
            if (primaryVelocity == null) {
              _controller.animateTo(0.0);
              return;
            }
            if (_controller.value > 0.5 || primaryVelocity < -1000) {
              _controller.animateTo(1.0);
            } else {
              _controller.animateTo(0.0);
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.menuOptions.map((option) => GestureDetector(
                    onTap: option.onTap,
                    child: Container(
                      width: _menuOptionWidth,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            option.icon,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            option.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ),

              LayoutBuilder(
                builder: (context, constraint) {
                  return SlideTransition(
                    position: animation,
                    child: SizedBox(
                      width: constraint.maxWidth,
                      // height: constraint.maxHeight,
                      child: widget.child,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}