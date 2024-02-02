import 'package:flutter/material.dart';

class AppLifecycleWidget extends StatefulWidget {
  final void Function(BuildContext context)? onCreated;
  final VoidCallback? onDestroyed;
  final VoidCallback? onMounted;
  final Widget Function(BuildContext context) builder;

  const AppLifecycleWidget({super.key, 
    this.onCreated,
    this.onDestroyed,
    this.onMounted,
    required this.builder,
  });

  @override
  _AppLifecycleWidgetState createState() => _AppLifecycleWidgetState();
}

class _AppLifecycleWidgetState extends State<AppLifecycleWidget> {
  @override
  void initState() {
    if (widget.onCreated != null) widget.onCreated!(context);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onMounted != null) widget.onMounted!();
    });
  }

  @override
  void dispose() {
    if (widget.onDestroyed != null) widget.onDestroyed!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
