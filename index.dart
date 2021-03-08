import 'package:js/js.dart';
import 'package:node_http/node_http.dart' as http;

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
  external void respondWith(Promise<Response> r);
}

@JS()
external void addEventListener(String type, void Function(FetchEvent event));

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}

void main() {
  addEventListener('fetch', allowInterop((FetchEvent event) async {
    /*
    handleRequest(event.request).then((res) {
      print('returned');
      print(res);
      event.respondWith(res);
    });
    */
    //event.respondWith(new Response("hi"));
    /*
    event.respondWith(new Future(() {
      print('yaharu');
      return new Response("yaharu");
    }));
    */

    /*
    event.respondWith(new Promise(allowInterop((resolve, reject) {
      new Future(() {
        print('yaharu1');
        return new Response("yaharu1");
      }).then(resolve, onError: reject);
    })));
    */

    event.respondWith(new Promise(allowInterop((resolve, reject) {
      handleRequest(event.request).then(resolve, onError: reject);
    })));

    /*
    return new Future(() {
      print('value ');
      event.respondWith(new Response("Hello"));
    });
    */
  }));
}

Future<Response> handleRequest(Request request) async {
  print(stringify(request));
  var uri = Uri.parse(request.url);
  uri.pathSegments.forEach((k) {
    print('path seg: $k');
  });
  uri.queryParameters.forEach((k, v) {
    print('key: $k - value: $v');
  });

  var res =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

/*
  var client = http.Client();
  var res = client
      .send(new http.Request('GET', Uri.parse('jsonplaceholder.typicode.com')));
      */

  print(res);

  return new Response("Dart Workers world!");
}
