abstract class IUseCase<T> {
  Future<T> call({Map<String, dynamic>? args});
}
