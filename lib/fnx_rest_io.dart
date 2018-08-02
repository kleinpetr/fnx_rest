// Copyright (c) 2016, Tomucha. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

///
/// Developer and Angular 2 friendly REST client.
/// Do this:
///
///       RestClient root = HttpRestClient.root("http://myapi.example/api/v1");
///
/// ... and start using it. See [RestClient] for more information.
///
library fnx_rest;

import 'dart:async';

import 'package:http/http.dart';
import 'package:http/src/response.dart';

import 'src/rest_client.dart';

export 'src/rest_client.dart';
export 'src/rest_listing.dart';

class IoRestClient extends RestClient {
  IoRestClient.root(String url) : this(null, url);
  IoRestClient(RestClient parent, String url)
      : super(new IOHttpClient(), parent, url);
}


class IOHttpClient extends RestHttpClient {
  IOClient _client = new IOClient();

  @override
  Future<Response> get(String url, {Map<String, String> headers}) {
    return _client.get(url, headers: headers);
  }

  @override
  Future<Response> delete(String url,
      {dynamic data, Map<String, String> headers}) async {
    Request request = new Request("DELETE", Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (data != null) {
      request.body = data;
    }
    return Response.fromStream(await _client.send(request));
  }

  @override
  Future<Response> post(String url, data, {Map<String, String> headers}) {
    return _client.post(url, headers: headers, body: data);
  }

  @override
  Future<Response> put(String url, data, {Map<String, String> headers}) {
    return _client.put(url, headers: headers, body: data);
  }

  @override
  Future<Response> head(String url, {Map<String, String> headers}) {
    return _client.head(url, headers: headers);
  }
}
