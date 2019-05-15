import 'package:flutter/material.dart';

class ListTileLates extends StatelessWidget{

  ListTileLates({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.padding,
    this.theme,
    this.icon
  }) : assert(title != null),
       assert(subtitle != null),
       super(key:key);

  final Text title;
  final Text subtitle;
  final EdgeInsetsGeometry padding;
  final Icon icon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: padding,
      child: ListTile(
        leading: CircleAvatar(
          child: icon ?? null,
          backgroundColor: theme ?? Theme.of(context).primaryColor,
        ),
        title: title ?? null,
        subtitle: subtitle ?? null,
      ),
    );
  }
  
}