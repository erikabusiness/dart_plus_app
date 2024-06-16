import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Grupo de testes simples", () {
    test("teste simples", () {
      String nome = "Marcos";
      expect(nome, "Marcos");
    });

    test("teste simples 2", () {
      String nome = "João";
      expect(nome, "João");
    });
  });
}
