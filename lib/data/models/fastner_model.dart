class Fastener {
  String status;
  String fastenerName;
  List<List<dynamic>> headType;
  List<String> threadTypes;
  List<String> meterials;
  double screwLength;
  double threadLength;
  double threadDiam;
  double headDiam;
  dynamic fastnerId;
  dynamic pennyType;

  Fastener({
    required this.status,
    required this.fastenerName,
    required this.headType,
    required this.meterials,
    required this.threadTypes,
    required this.screwLength,
    required this.threadLength,
    required this.threadDiam,
    required this.headDiam,
    required this.pennyType,
    this.fastnerId,
  });

  factory Fastener.fromJson(Map<String, dynamic> json) {
    return Fastener(
      status: json['status'],
      fastenerName: json['fastner_name'],
      headType: List<List<dynamic>>.from(
          json['head_type'].map((type) => List<dynamic>.from(type))),
      threadTypes: json['thread_types'],
      meterials: json['meterials'],
      screwLength: json['screw_length'].toDouble(),
      threadLength: json['thread_length'].toDouble(),
      threadDiam: json['thread_diam'].toDouble(),
      headDiam: json['head_diam'].toDouble(),
      fastnerId: json['fastner_id'],
      pennyType: json['penny_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'fastner_name': fastenerName,
      'head_type':
          List<dynamic>.from(headType.map((type) => List<dynamic>.from(type))),
      'screw_length': screwLength,
      'thread_length': threadLength,
      'thread_diam': threadDiam,
      'head_diam': headDiam,
      'fastner_id': fastnerId,
    };
  }
}
