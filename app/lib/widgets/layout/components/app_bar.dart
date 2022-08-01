import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasDrawer;

  const MyAppBar({Key? key, required this.title, this.hasDrawer = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BusinessLogic? bl = context.read<BusinessLogic>();
    return AppBar(
      leading: hasDrawer
          ? new IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            )
          : new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => {Navigator.of(context).pop(true)},
            ),
      centerTitle: true,
      title: Text(this.title, style: TextStyle(color: Colors.white)),
      actions: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<int>(
                stream: bl?.offline.queueLengthStream.stream,
                builder: (context, snapshot) {
                  final content;
                  final borderColor;
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data! > 0) {
                    return SizedBox.square(
                      dimension: 30,
                      child: Container(
                        child: Center(
                          child: Text(snapshot.data.toString()),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
