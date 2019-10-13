import 'package:cloud_firestore/cloud_firestore.dart';

class Entity {
  final String wordpair;
  final bool isFavorite;
  final DocumentReference reference;

  Entity.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['word'] != null),
        assert(map['isFavorite'] != null),
        wordpair = map['word'],
        isFavorite = map['isFavorite'];

  Entity.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "WordPair<$wordpair:$isFavorite>";
}
