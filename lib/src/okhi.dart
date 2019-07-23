import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:okhi_flutter_widget/src/models/invalid_arguments.dart';
import 'package:okhi_flutter_widget/src/models/okhi_auth.dart';
import 'package:okhi_flutter_widget/src/models/okhi_launch_mode.dart';
import 'package:okhi_flutter_widget/src/models/okhi_error.dart';
import 'package:okhi_flutter_widget/src/models/okhi_location.dart';
import 'package:okhi_flutter_widget/src/models/okhi_style.dart';
import 'package:okhi_flutter_widget/src/models/okhi_user.dart';
import 'package:okhi_flutter_widget/src/models/transmission.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OkHi extends StatefulWidget {
  final OkHiStyle style;
  final OkHiUser user;
  final OkHiAuth auth;
  final OkHiLocation location;
  final Function(OkHiLocation, OkHiUser) onSucess;
  final Function(OkHiError error) onError;
  final OkHiLaunchMode mode;
  final Map<String, dynamic> parent = {
    "name": "okhi_flutter_widget",
    "version": "1.0.0",
    "build": 1,
    "namespace": "com.develop.okhi_flutter_widget.okhi"
  };
  final String okHeartUrl = 'https://manager-v4.okhi.co';

  OkHi({
    @required this.user,
    @required this.auth,
    @required this.onSucess,
    @required this.onError,
    this.style,
    this.location,
    this.mode = OkHiLaunchMode.start_app,
  }) {
    if (this.user.phone == null) {
      throw new InvalidArguments('Missing phone number in user');
    }
    if (this.auth.apiKey == null) {
      throw new InvalidArguments('Missing apiKey in auth map');
    }
    if (this.location != null && this.location.id == null) {
      throw new InvalidArguments('Missing id in location');
    }
  }

  @override
  _OkHi createState() => _OkHi();
}

class _OkHi extends State<OkHi> {
  WebViewController _controller;
  Map<String, dynamic> _startPayload;

  @override
  void initState() {
    super.initState();
    _startPayload = {
      "style": widget.style != null ? widget.style.toJSON() : {},
      "user": widget.user.toJSON() ?? {},
      "auth": widget.auth.toJSON() ?? {},
      "parent": widget.parent ?? {},
    };
    if (widget.location != null && widget.location.id != null) {
      _startPayload['location'] = {"id": widget.location.id};
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.okHeartUrl,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: Set.from(
        [
          JavascriptChannel(
            name: 'Flutter',
            onMessageReceived: (JavascriptMessage message) {
              final Transmission transmission =
                  Transmission.fromJSON(json.decode(message.message));
              _handleIncomingTransmission(transmission);
            },
          ),
          JavascriptChannel(
            name: 'FlutterDev',
            onMessageReceived: (JavascriptMessage message) {
              // print(message.message);
            },
          ),
        ],
      ),
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
    );
  }

  void _handleIncomingTransmission(Transmission transmission) {
    switch (transmission.message) {
      case 'app_state':
        _sendStartTransmission();
        break;
      case 'location_created':
        _handleSuccess(transmission);
        break;
      case 'location_updated':
        _handleSuccess(transmission);
        break;
      case 'location_selected':
        _handleSuccess(transmission);
        break;
      case 'fatal_exit':
        _handleFailure(transmission);
        break;
      default:
        break;
    }
  }

  void _sendStartTransmission() {
    if (_controller == null) return;
    final String mode = widget.mode.toString().split('.').last;
    final String transmission =
        Transmission(message: mode, payload: _startPayload).toJSON();
    _controller.evaluateJavascript('receiveFlutterMessage($transmission)');
  }

  void _handleSuccess(Transmission transmission) {
    final OkHiLocation location =
        OkHiLocation.fromJSON(transmission.payload['location']);
    final OkHiUser user = OkHiUser.fromJSON(transmission.payload['user']);
    widget.onSucess(location, user);
  }

  void _handleFailure(Transmission transmission) {
    final OkHiError error = OkHiError.fromTransmission(transmission);
    widget.onError(error);
  }
}
