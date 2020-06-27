import 'dart:math' as math;
import 'dart:ui';
import 'dart:async';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:dashboard_reborn/utils/text_styles.dart';
import 'package:dashboard_reborn/utils/ui_helpers.dart';
import 'package:dashboard_reborn/widgets/sexy_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:call_number/call_number.dart';

const double minHeight = 80;
const double iconStartSize = 75;
const double iconEndSize = 110;
const double iconStartMarginTop = -15;
const double iconEndMarginTop = 50;
const double iconsVerticalSpacing = 0;
const double iconsHorizontalSpacing = 0;
AnimationController controller;

void toggleBottomSheet() =>
    controller.fling(velocity: isBottomSheetOpen ? -2 : 2);
bool get isBottomSheetOpen => (controller.status == AnimationStatus.completed);

class SexyBottomSheet extends StatefulWidget {
  @override
  _SexyBottomSheetState createState() => _SexyBottomSheetState();
}

    int index ;
class _SexyBottomSheetState extends State<SexyBottomSheet>
    with SingleTickerProviderStateMixin {
  double get maxHeight => MediaQuery.of(context).size.height;

  double get headerTopMargin =>
      lerp(16, 0 + MediaQuery.of(context).padding.top);

  double get itemBorderRadius => lerp(8, 15);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => itemBorderRadius;

  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) =>
      lerp(
        iconStartMarginTop,
        iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize),
      ) +
      headerTopMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) => lerpDouble(min, max, controller.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: toggleBottomSheet,
            onVerticalDragUpdate: handleDragUpdate,
            onVerticalDragEnd: handleDragEnd,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                   // color: shadowColor(context),
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: Material(
            //    color: invertInvertColorsMild(context),
                elevation: 10.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
      //          shadowColor: shadowColor(context),
                child: InkWell(
                  onLongPress:() async {
                    final Email email = Email(
  body: l_body[0],
  subject: l_subject[0],
  recipients: [l_email[0]],
  isHTML: false,
);
                   // _launchURL("hssanrehman01398@gmail.com", "Sexual Harassment", "hassan");
                  
                  await FlutterEmailSender.send(email);
                  await new  CallNumber().callNumber(l_number[0]);
                 // launch("tel:+92 (21) 32413232");
                  }, 
                  
                  //splashColor: invertColorsMaterial(context),

                  
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: <Widget>[
                        MenuButton(),
                        
                        for (SheetItem item in items) buildFullItem(item),
                        for (SheetItem item in items) buildIcon(item),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildIcon(SheetItem item) {
    int index = items.indexOf(item);
    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: Image.asset(
            l1[index],
            
            fit: BoxFit.cover,
            alignment: Alignment(lerp(0, 0), 0),
          ),
        ),
      ),
    );
  }

  Widget buildFullItem(SheetItem item) {
    index = items.indexOf(item);
    
    return ExpandedSheetItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: iconSize,
      isVisible: controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: item.title,
    
    );
  }

  void handleDragUpdate(DragUpdateDetails details) {
    controller.value -= details.primaryDelta / maxHeight;
  }

  void handleDragEnd(DragEndDetails details) {
    //print("hassan");
    if (controller.isAnimating ||
        controller.status == AnimationStatus.completed) 
       // _launchURL("hassan", "usman", "fafa");
        return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      controller.fling(
        velocity: math.max(2.0, -flingVelocity),
      );
    else if (flingVelocity > 0.0)
      controller.fling(
        velocity: math.min(-2.0, -flingVelocity),
      );
    else
      controller.fling(velocity: controller.value < 0.5 ? -2.0 : 2.0);
  
  }
}

class ExpandedSheetItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;

  const ExpandedSheetItem(
      {Key key,
      this.topMargin,
      this.height,
      this.isVisible,
      this.borderRadius,
      this.title,
      this.leftMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 100),
        child: SexyTile(
          
         color: invertColorsMaterial(context),
         splashColor: invertInvertColorsMaterial(context),
         
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
         
              Padding(
                padding: EdgeInsets.only(
                  left: 100.0,
                ),
                child: Text(
       //   onTap:_launchURL(toMailId, subject, body),
              // title,
                l[int.parse(title)-1],
            
                  style: isThemeCurrentlyDark(context)
                      ? SubHeadingStylesMaterial.light
                      : SubHeadingStylesMaterial.dark,
                ),
              ),
            ],
          ),
          onTap: doNothing,
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        Text(
          'Fix me $title',
        ),
      
      ],
    );
  }
}

final List<SheetItem> items = [
  SheetItem('assets/icon/icon-legacy.png', "1"),
  SheetItem('assets/icon/icon-legacy.png', "2"),
  SheetItem('assets/icon/icon-legacy.png', "3"),
  SheetItem('assets/icon/icon-legacy.png', "4"),
  
  SheetItem('assets/icon/icon-legacy.png', "5"),
  
];
List l1=["assets/icon/sindhpolice.png","assets/icon/sindhrangers.jpg","assets/icon/ambulance.png","assets/icon/fire.png","assets/icon/h.png","assets/icon/h.png"];
List l=["Police","Rangers","Ambulance","Fire Brigade","AASHA"];
List l_email=["feedback@sindhpolice.gov.pk","help@pakistanrangerssindh.org","lnfo@edhi.org","feedback@sindhpolice.gov.pk","info@mehergarh.org"];
List l_number=["15","1101","02132413232","16","051-2102012"];
List l_body=[
"This email is auto-generated to inform you about Theft or Harassment with M.Ahmad at location ",
"This email is auto-generated to inform you about Theft or Murder witnessed by M.Ahmad at location ",
"This email is auto-generated to inform you about need of Ambulance with reference of M.Ahmad at location ",
"This email is auto-generated to inform you about Fire Emergency with reference of M.Ahmad at location ",
"This email is auto-generated to inform you about Sexual Harrasment with or witnessed by M.Ahmad  at location ",


];
List l_subject=["theft/Harassment","Theft/Murder","Emergency Ambulance","Fire Emergency","Sexual Harassment"];
class SheetItem {
  final String assetName;
  final String title;

  SheetItem(this.assetName, this.title);
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {}
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -5,
      bottom: 10,
      
      child: GestureDetector(
        
        onTap: toggleBottomSheet,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          size: 24.0,
          progress: controller,
          semanticLabel: 'Open/close',
         color: invertColorsMild(context),
        ),
      ),
    );
  }
}
_launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }