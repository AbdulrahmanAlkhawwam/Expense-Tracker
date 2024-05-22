import 'package:flutter/material.dart';

class BoundedListView extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget? child;
  final List<Widget>? children;

  const BoundedListView({
    super.key,
    this.padding,
    this.child,
    this.children,
  }) : assert(child != null || children != null,
  "You must provide either child or children");

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bottomPadding = MediaQuery.of(context).padding.bottom;
      return SingleChildScrollView(
        padding: padding?.copyWith(
          bottom: (padding?.bottom ?? 0) + bottomPadding,
        ) ??
            EdgeInsets.only(bottom: bottomPadding),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            minHeight: constraints.maxHeight -
                (padding?.bottom ?? 0) -
                (padding?.top ?? 0) -
                bottomPadding,
          ),
          child: IntrinsicHeight(
            child: child ??
                Column(
                  children: children!,
                ),
          ),
        ),
      );
    });
  }
}