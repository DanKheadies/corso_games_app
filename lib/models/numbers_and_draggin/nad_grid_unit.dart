import 'package:equatable/equatable.dart';

class NadGridUnit extends Equatable {
  final String id;
  final String? data;
  final double left;
  final double top;

  const NadGridUnit({
    required this.id,
    this.data,
    required this.left,
    required this.top,
  });

  @override
  List<Object?> get props => [
        id,
        data,
        left,
        top,
      ];
}
