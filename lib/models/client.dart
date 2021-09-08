class Client {
  final String uuid;

  Client({required this.uuid});

  factory Client.initialData() {
    return Client(uuid: '');
  }
}

class ClientData {

  final String uid;
  final String name;
  final String sugars;
  final int strength;

  ClientData({required this.uid,required this.sugars,required this.strength,required this.name });

}