class BlockedContentModel {
  String userId;
  String lentaId;
  String id;

  BlockedContentModel({
    required this.userId,
    required this.lentaId,
    this.id = '',
  });

  factory BlockedContentModel.fromJson(Map<String, dynamic> json) =>
      BlockedContentModel(
        userId: json['user_id']??'',
        lentaId: json['lenta_id']??'',
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'lenta_id': lentaId,
      };
}
