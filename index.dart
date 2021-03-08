import 'package:js/js.dart';

@JS()
class Request {
  external String get url;
}

@JS()
class Response {
  external factory Response(String body);
}

@JS('JSON.stringify')
external String stringify(Object obj);

@JS()
class FetchEvent {
  external Request get request;
  external void respondWith(Response r);
}

@JS()
external void addEventListener(String type, void Function(FetchEvent event));

void main() {
  addEventListener('fetch', allowInterop((FetchEvent event) {
    event.respondWith(handleRequest(event.request));
  }));
}

Response handleRequest(Request request) {
  print(stringify(request));
  var uri = Uri.parse(request.url);
  uri.pathSegments.forEach((k) {
    print('path seg: $k');
  });
  uri.queryParameters.forEach((k, v) {
    print('key: $k - value: $v');
  });
  return new Response("Dart Workers world!");
}
