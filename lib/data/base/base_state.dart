import 'package:flutter/cupertino.dart';


abstract class ProviderState<S extends StatefulWidget, P extends ChangeNotifier>
    extends State<S> {
  late P provider;

  ProviderState({required this.provider});

  @mustCallSuper
  void executeAfterFirstBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }
}
