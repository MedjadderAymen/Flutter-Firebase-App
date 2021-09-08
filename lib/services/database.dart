import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uuid;

  DataBaseService(this.uuid);

  DataBaseService.withoutUUID() : uuid = "";

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uuid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // list of brews from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc['name'] ?? '',
          sugars: doc['sugars'] ?? '0',
          strength: doc['strength'] ?? 0);
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((_brewListFromSnapshot));
  }

  ClientData _clientDataFrmSnapshot(DocumentSnapshot documentSnapshot){

    return ClientData(uid: uuid, sugars: documentSnapshot['sugars'], strength: documentSnapshot['strength'], name: documentSnapshot['name']);

  }

  //get user doc stream
  Stream<ClientData> get clientData {
    return brewCollection.doc(uuid).snapshots().map(_clientDataFrmSnapshot);
  }
}