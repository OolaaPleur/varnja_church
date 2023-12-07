import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:varnja_church/screens/pages/contacts/widgets/contacts_data.dart';
import 'package:varnja_church/screens/pages/contacts/widgets/map_widget.dart';

@RoutePage()
class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isWideScreen = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: isWideScreen
                  ? SingleChildScrollView(
                    child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[ContactsData(), MapWidget()],
              ),
                  )
                  : SingleChildScrollView(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ContactsData(), MapWidget()],
              ),
                  ),
            ),
          ),
        );
      },
    );
  }
}
