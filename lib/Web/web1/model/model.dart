class Address {
  final String NamaKota;
  final String id;
  final String NamaNegara;
  final String KodePos;

  const Address({
    required this.NamaKota,
    required this.NamaNegara,
    required this.KodePos,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        NamaKota: json['NamaKota'],
        NamaNegara: json['NamaNegara'],
        KodePos: json['KodePos'],
        id: json['id']);
  }
}
