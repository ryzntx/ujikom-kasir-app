import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

void routeNavigator(BuildContext ctx, String route) {
  Navigator.of(ctx).pushNamed(route);
}

void pageNavigator(BuildContext ctx, Widget pages) {
  Navigator.of(ctx)
      .push(PageTransition(child: pages, type: PageTransitionType.fade));
}

void routeNavigatorReplacement(BuildContext ctx, String route) {
  Navigator.of(ctx).pushReplacementNamed(route);
}

void pageNavigatorReplacement(BuildContext ctx, Widget pages) {
  Navigator.of(ctx).pushReplacement(
      PageTransition(child: pages, type: PageTransitionType.fade));
}

void pageNavigatorRemoveUntil(BuildContext ctx, Widget pages) {
  Navigator.of(ctx).pushAndRemoveUntil(
      PageTransition(child: pages, type: PageTransitionType.fade),
      (route) => false);
}

void routeNavigatorRemoveUntil(BuildContext ctx, String route) {
  Navigator.of(ctx).pushNamedAndRemoveUntil(route, (route) => false);
}
