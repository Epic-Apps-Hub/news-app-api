import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SidebarItem extends StatelessWidget {
  final isSelected;
  final String text;
  final Function onTabTap;

  const SidebarItem({
    Key key,
    this.isSelected,
    this.text,
    this.onTabTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.58,
      child: GestureDetector(
        onTap: onTabTap,
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? Color(0xFF1cf37f)
                      : Colors
                          .transparent), //          color: ThemeProvider.controllerOf(context).currentThemeId == "dark"? Colors.white:Colors.black87,
            ),
            AnimatedDefaultTextStyle(
              child: Text(
                text,
              ),
              duration: const Duration(milliseconds: 200),
              style: isSelected
                  ? TextStyle(
                      fontSize: 20.0,
                      color:
                          ThemeProvider.controllerOf(context).currentThemeId ==
                                  "dark"
                              ? Colors.white
                              : Colors.black87,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(
                      fontSize: 20.0,
                      color:
                          ThemeProvider.controllerOf(context).currentThemeId ==
                                  "dark"
                              ? Colors.white38
                              : Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
