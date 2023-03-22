class Index {
  final int row;
  final int column;

  Index(
    this.row,
    this.column,
  );

  // @override
  // bool operator ==(other) {
  //   return ((other.row == row) && (other.column == column));
  // }

  // @override
  // // TODO: implement hashCode
  // int get hashCode => super.hashCode;

  @override
  String toString() {
    return "Index($row,$column)";
  }
}
