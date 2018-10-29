import 'package:flutter/widgets.dart';

/// An extension class to the Flutter standard State. The class provides getter
/// and setters for updating the message section of the loading screen
///
/// Note: The class is marked as abstract to avoid IDE issues that expects
/// protected methods to be overloaded
abstract class MessageState<T extends StatefulWidget> extends State<T> {
  /// The state variable that will hold the latest message that needs to be
  /// displayed.
  ///
  /// Note: Although Flutter standard allow member variables to be used from
  /// instance object reference, this is not a best practice with OOP. OOP
  /// design proposes that member variables should be accessed through getter
  /// and setter methods.
  @protected
  String _message = 'Loading . . .';

  /// The member variable is set as protected this it is not exposed to the
  /// widget state class. As a workaround a protected setter is set so it is
  /// not used outside the package
  @protected
  set initialMessage(String message) => _message = message;

  /// Setter for the message variable
  set setMessage(String message) => setState(() {
        _message = message;
      });

  /// Getter for the message variable
  String get getMessage => _message;
}
