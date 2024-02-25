import 'dart:js_interop';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/src/impl/entropy.dart';

import 'web_crypto.dart';
import 'platform_check.dart';

class PlatformWeb extends Platform {
  static final PlatformWeb instance = PlatformWeb();
  static bool useBuiltInRng = false;

  PlatformWeb() {
    try {
      Random.secure();
      useBuiltInRng = true;
    } on UnsupportedError {
      useBuiltInRng = false;
    }
  }

  @override
  bool get isNative => false;

  @override
  String get platform => 'web';

  @override
  EntropySource platformEntropySource() {
    if (useBuiltInRng) {
      return _JsBuiltInEntropySource();
    } else {
      //
      // Assume that if we cannot get a built in Secure RNG then we are
      // probably on NodeJS.
      //
      return _JsEntropySource();
    }
  }
}

// Uses the built in entropy source
class _JsBuiltInEntropySource implements EntropySource {
  final _src = Random.secure();

  @override
  Uint8List getBytes(int len) {
    return Uint8List.fromList(
        List<int>.generate(len, (i) => _src.nextInt(256)));
  }
}

///
class _JsEntropySource implements EntropySource {
  @override
  Uint8List getBytes(int len) {
    var list = Uint8List(len).toJS;
    window.crypto.getRandomValues(list);
    return list.toDart;
  }
}

Platform getPlatform() => PlatformWeb.instance;
