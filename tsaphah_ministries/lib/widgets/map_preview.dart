// This app is web-only (see web/ — no other platform folders exist),
// so the deprecated dart:html / web-library-only APIs below are safe.
// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

/// Embeds a keyless Google Maps preview for [query] as an iframe —
/// this app is web-only, and the public maps.google.com embed URL
/// needs no API key (the same mechanism used to paste a map into any
/// website).
class MapPreview extends StatefulWidget {
  final String query;

  const MapPreview({super.key, required this.query});

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  static final Set<String> _registeredViewTypes = {};
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'map-preview-${widget.query.hashCode}';
    if (_registeredViewTypes.add(_viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(_viewType, (int _) {
        return html.IFrameElement()
          ..src =
              'https://maps.google.com/maps?q=${Uri.encodeComponent(widget.query)}&z=15&output=embed'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
