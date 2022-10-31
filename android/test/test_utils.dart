import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Allows pumping scaffolds since scaffolds need material app parent.
/// Providers used in the page is needed for pumping the page
Widget appWidget(Widget widget, List<SingleChildWidget> providerList) => MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        builder: (_, __) => MultiProvider(
          providers: providerList,
          child: Builder(builder: (_) => widget),
        ),
      ),
    );
