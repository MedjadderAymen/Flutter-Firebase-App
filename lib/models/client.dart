class Client {
  final String uuid;

  Client({required this.uuid});

  factory Client.initialData() {
    return Client(uuid: '');
  }
}
