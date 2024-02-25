library web_crypto;

import 'dart:js_interop';

/// Top-level window object.
@JS()
external Window get window;

/// https://developer.mozilla.org/en-US/docs/Web/API/Window
@JS('Window')
extension type Window(JSObject _) implements JSObject {
  /// https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
  external Crypto get crypto;
}

/// https://developer.mozilla.org/en-US/docs/Web/API/Crypto
@JS('Crypto')
extension type Crypto(JSObject _) implements JSObject {
  /// https://developer.mozilla.org/en-US/docs/Web/API/Crypto/getRandomValues
  external JSUint8Array getRandomValues(JSUint8Array array);
}
