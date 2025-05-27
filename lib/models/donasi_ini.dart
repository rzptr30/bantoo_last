class Donasi {
  final int? id;
  final String? nama;
  final String? title;
  final String? description;
  final double? targetAmount;
  final double? collectedAmount;
  final String? deadline;
  final int? createdBy;
  final String? createdAt;
  final String? foto;
  final String? imageUrl;
  final double? nominal;
  final String? pesan;
  final double? progress;
  final bool? isEmergency;
  final double? target;
  final double? current;

  // Getter agar widget bisa akses data seragam tanpa cek null satu-satu
  String get displayTitle => title ?? nama ?? '';
  String get displayImage =>
      (imageUrl != null && imageUrl!.isNotEmpty)
          ? imageUrl!
          : (foto ?? '');
  double get displayTarget =>
      targetAmount ?? target ?? 1.0;
  double get displayCollected =>
      collectedAmount ?? current ?? nominal ?? 0.0;
  String get displayDeadline => deadline ?? '';

  double get progressPercentage {
    if (progress != null) return progress!;
    final target = displayTarget;
    final collected = displayCollected;
    if (target == 0) return 0.0;
    double percent = collected / target;
    return percent > 1 ? 1.0 : percent;
  }

  Donasi({
    this.id,
    this.nama,
    this.title,
    this.description,
    this.targetAmount,
    this.collectedAmount,
    this.deadline,
    this.createdBy,
    this.createdAt,
    this.foto,
    this.imageUrl,
    this.nominal,
    this.pesan,
    this.progress,
    this.isEmergency,
    this.target,
    this.current,
  });

factory Donasi.fromJson(Map<String, dynamic> json) {
  return Donasi(
    id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
    nama: json['nama'],
    title: json['title'],
    description: json['description'],
    targetAmount: json['target_amount'] != null ? double.tryParse(json['target_amount'].toString()) : null,
    collectedAmount: json['collected_amount'] != null ? double.tryParse(json['collected_amount'].toString()) : null,
    deadline: json['deadline'],
    createdBy: json['created_by'] != null ? int.tryParse(json['created_by'].toString()) : null,
    createdAt: json['created_at'],
    foto: json['foto'],
    imageUrl: json['image_url'],
    nominal: json['nominal'] != null ? double.tryParse(json['nominal'].toString()) : null,
    pesan: json['pesan'],
    progress: json['progress'] != null ? double.tryParse(json['progress'].toString()) : null,
    isEmergency: json['is_emergency'] == 1 || json['is_emergency'] == '1' || json['is_emergency'] == true,
    target: json['target'] != null ? double.tryParse(json['target'].toString()) : null,
    current: json['current'] != null ? double.tryParse(json['current'].toString()) : null,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'title': title,
      'description': description,
      'target_amount': targetAmount,
      'collected_amount': collectedAmount,
      'deadline': deadline,
      'created_by': createdBy,
      'created_at': createdAt,
      'foto': foto,
      'image_url': imageUrl,
      'nominal': nominal,
      'pesan': pesan,
      'progress': progress,
      'is_emergency': isEmergency,
      'target': target,
      'current': current,
    };
  }
}