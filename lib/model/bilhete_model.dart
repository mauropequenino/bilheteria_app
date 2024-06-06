class BilheteModel {
  final String id;
  final String tituloEvento;
  final String descricao;
  final String localizacao;
  final String provincia;
  final String horaInicio;
  final String preco;

  BilheteModel({
    required this.id,
    required this.tituloEvento,
    required this.descricao,
    required this.localizacao,
    required this.provincia,
    required this.horaInicio,
    required this.preco, required 
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tituloEvento': tituloEvento,
      'descricao': descricao,
      'localizacao': localizacao,
      'provincia': provincia,
      'horaInicio': horaInicio,
      'preco': preco
    };
  }

  static BilheteModel fromMap(Map<String, dynamic> map) {
    return BilheteModel(
      id: map['id'],
      tituloEvento: map['tituloEvento'],
      descricao: map['descricao'],
      localizacao: map['localizacao'],
      provincia: map['provincia'],
      horaInicio: map['horaInicio'],
      preco: map['preco'],
    );
  }

}