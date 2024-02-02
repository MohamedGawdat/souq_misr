class RequestBody {
  Map<String, dynamic> body = {};

  RequestBody(Map<String, dynamic> data) {
    _addItems(data);
  }

  RequestBody add(String key, dynamic value) {
    body.putIfAbsent(key, () => value);
    return this;
  }

  RequestBody remove(String key) {
    if (body.containsKey(key)) {
      body.remove(key);
    }
    return this;
  }

  Map<String, dynamic> getBody() {
    return body;
  }

  void _addItems(Map<String, dynamic> data) {
    data.forEach((k, v) {
      body.putIfAbsent(k, () => v);
    });
  }

  void addAll(Map<String, dynamic>? data) {
    _addItems(data!);
  }
}
