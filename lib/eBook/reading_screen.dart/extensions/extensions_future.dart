extension FutureExtensions on int {
  msAfter({required Function run}) {
    Future.delayed(Duration(milliseconds: this), () => run());
  }
}
