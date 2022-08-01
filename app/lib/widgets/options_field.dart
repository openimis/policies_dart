import 'package:flutter/material.dart';

class OptionsField extends StatelessWidget {
  /// you can add more fields that meet your needs
  final IconData icon;
  final String title;
  final Color color;
  final Color textColor;
  final String routeName;
  final int rows;

  const OptionsField({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    this.textColor = Colors.black,
    required this.routeName,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, this.routeName);
      },
      child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Container(
              width: MediaQuery.of(context).size.width * 75 / 100,
              height: MediaQuery.of(context).size.height / (this.rows + 1.2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: this.color),
              child: Column(
                children: [
                  Expanded(
                      child: new LayoutBuilder(builder: (context, constraint) {
                        return new Icon(
                          this.icon,
                          size: constraint.biggest.height,
                          color: textColor,
                        );
                      }),
                      flex: 7),
                  Expanded(
                      child: Text(
                        this.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: textColor),
                      ),
                      flex: 3)
                ],
              ))),
    );
  }
}
