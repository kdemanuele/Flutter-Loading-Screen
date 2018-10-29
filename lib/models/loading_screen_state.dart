import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:clounce_loading_screen/widget/loading_screen.dart';
import 'package:clounce_loading_screen/models/message_state.dart';

/// The custom state that is used by the Loading Screen widget to handle the
/// messages that are provided by the initializer methods.
///
/// Note: Although the class is not exported from the package as not required by
/// the implementers using the package, the protected metatag is added to make
/// the code clearer.
@protected
class LoadingScreenState extends MessageState<LoadingScreen> {

  /// Initialise the state
  @override
  void initState() {
    super.initState();

    /// If the LoadingScreen widget has an initial message set, then the default
    /// message in the MessageState class needs to be updated
    if (widget.initialMessage != null) {
      initialMessage = widget.initialMessage;
    }

    /// We require the initializers to run after the loading screen is rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      runInitTasks();
    });
  }

  /// This method calls the initializers and once they complete redirects to
  /// the widget provided in navigateAfterInit
  @protected
  Future runInitTasks() async {
    /// Run each initializer method sequentially
    Future.forEach(widget.initializers, (init) => init(this)).whenComplete(() {
      // When all the initializers has been called and terminated their
      // execution. The screen is navigated to the next scaffolding widget
      if (widget.navigateToWidget is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateToWidget);
      } else if (widget.navigateToWidget is Widget) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => widget.navigateToWidget));
      } else {
        throw new ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  /// Render the LoadingScreen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Paint the area where the inner widgets are loaded with the
            /// background to keep consistency with the screen background
            new Container(
              decoration: BoxDecoration(color: widget.backgroundColor),
            ),
            /// Render the background image
            new Container(
              child: widget.image,
            ),
            /// Render the Title widget, loader and messages below each other
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                          ),
                          widget.title,
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Loader Animation Widget
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            widget.loaderColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      Text(getMessage, style: widget.styleTextUnderTheLoader),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}