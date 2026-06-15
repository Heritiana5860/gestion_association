

final datasourceProvider = Provider((ref) {
    final dio = ref.watch(dioProvider);
    return PresidentDatasource( dio: dio);
});