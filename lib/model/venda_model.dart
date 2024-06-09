class VendaModel {
  final String id;
  final String idCliente;
  final String idBilhette;
  final int quantidade;
  final double precoTotal;
  //final String? dataCricao;

  VendaModel(
      {required this.id,
      required this.idCliente,
      required this.idBilhette,
      required this.quantidade,
      required this.precoTotal,
      //this.dataCricao
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCliente': idCliente,
      'idBilhete': idBilhette,
      'quantidade': quantidade,
      'total': precoTotal,
      //'dataCricao': dataCricao
    };
  }

  static VendaModel fromMap(Map<String, dynamic> map) {
    return VendaModel(
        id: map['id'],
        idCliente: map['idCliente'],
        idBilhette: map['idBilhete'],
        quantidade: map['quantidade'],
        precoTotal: map['total']
        //: map['dataCricao']
    );
  }
}
