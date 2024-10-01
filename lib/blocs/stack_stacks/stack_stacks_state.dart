part of 'stack_stacks_bloc.dart';

class StackStacksState extends Equatable {
  final List<StacksBrickStack> brickStacks;

  const StackStacksState({
    this.brickStacks = const [],
  });

  @override
  List<Object> get props => [
        brickStacks,
      ];

  factory StackStacksState.fromJson(Map<String, dynamic> json) {
    return const StackStacksState(
      brickStacks: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
