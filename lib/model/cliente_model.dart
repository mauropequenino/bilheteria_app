class ClienteModel {
  final String id;
  final String nome;
  // String? dataCriacao;

  ClienteModel({
    required this.id,
    required this.nome,
    //this.dataCriacao
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome,
     //'dataCriacao': dataCriacao
     };
  }

  static ClienteModel fromMap(Map<String, dynamic> map) {
    return ClienteModel(id: map['id'], nome: map['nome'], 
    ///dataCriacao: map['dataCriacao']
    );
  }
}
