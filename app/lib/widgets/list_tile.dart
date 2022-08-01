import 'package:flutter/material.dart';

class OpenImisListTile extends StatelessWidget {
  final String? header;
  final String? bodyText;
  final IconData? icon;
  final void Function()? onPress;

  const OpenImisListTile({
    Key? key,
    required this.onPress,
    this.bodyText = null,
    this.header = null,
    this.icon = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD5D3D3),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: header != null
              ? Text(
                  header!,
                  style: bodyText != null
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      : null,
                )
              : null,
          subtitle: bodyText != null ? Text(bodyText!) : null,
          trailing: icon != null
              ? Icon(
                  icon,
                  color: Color(0xFF303030),
                  size: 20,
                )
              : null,
          dense: false,
          contentPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 20, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
