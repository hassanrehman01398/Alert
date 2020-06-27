import 'package:dashboard_reborn/pages/about_page.dart';
import 'package:dashboard_reborn/pages/imagecapture1.dart';
import 'package:dashboard_reborn/pages/material_page.dart';
import 'package:dashboard_reborn/ui/home/home_screen.dart';
import 'package:dashboard_reborn/utils/colors.dart';
import 'package:dashboard_reborn/utils/text_styles.dart';
import 'package:dashboard_reborn/utils/ui_helpers.dart';
import 'package:dashboard_reborn/widgets/sexy_tile.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//this page is based on 

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> itemNames = [
      'Sound Record',
      'Record',
      'News Feed',
    ]; //name of each individual tile

    return Scaffold(
      backgroundColor: invertInvertColorsStrong(context),
      
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 40.0,
                top: 60.0,
                bottom: 10.0,
              ),
          
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                // child: new Image.asset(
                //   'assets/icon/Logo(transparent).png',
                //   width: 100,
                //   height:120,
                //   fit: BoxFit.fill,
                // ),
                
                RichText(
                textAlign: TextAlign.center,
                
              
                text: TextSpan(
                    text: 'A',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: '!',
                        style: TextStyle(color: Colors.yellow, fontSize: 60),
                      ),
                      TextSpan(
                        text: 'E',
                        style: TextStyle(color: Colors.red, fontSize:40),
                      ),
                      TextSpan(
                        text: 'RT',
                        style: TextStyle(color: Colors.red, fontSize: 40),
                      ),
                    ]),
              )
              
                /*
                  Text(
                    'Alert',
                    style: isThemeCurrentlyDark(context)
                        ? TitleStylesDefault.white
                       // :Image.asset('assets/icon/logowhite (transparent).png')    
       
                        : TitleStylesDefault.black,

                 
                  ),
                */
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
                children: List.generate(
                  itemNames.length,
                  (index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Hero(
                          tag:
                              'tile$index', //using a different hero widget tag for
                          // each page mapped to the page's index value
                          child: SexyTile(),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Hero(
                                    tag: 'title$index',
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        '${itemNames[index]}',
                                        style: isThemeCurrentlyDark(context)
                                            ? LabelStyles.white
                                            : LabelStyles.black,
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              splashColor: MyColors.accent,
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) {
                                      if (index == 0) {
                                        return MyMaterialPage();
                                      } else if (index == 1) {
                                        return ImageCapture();
                                      } else if (index == 2) {
                                        return HomeScreen();
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: isThemeCurrentlyDark(context)
            ? Icon(
                EvaIcons.sun,
                size: 30.0,
              ) //show sun icon when in dark mode
            : Icon(
                EvaIcons.moon,
                size: 26.0,
              ), //show moon icon when in light mode
        tooltip: isThemeCurrentlyDark(context)
            ? 'Switch to light mode'
            : 'Switch to dark mode',
        foregroundColor: invertInvertColorsStrong(context),
        backgroundColor: invertInvertColorsTheme(context),
        elevation: 5.0,
        onPressed: () {
          DynamicTheme.of(context).setBrightness(
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark);
        },
      ),
    );
  }
}
