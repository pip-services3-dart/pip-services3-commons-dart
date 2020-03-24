import "package:test/test.dart";

import "../../lib/src/random/RandomBoolean.dart";

void main() {
  group('RandomBoolean', () {
      test('Chance', () {
        var value = RandomBoolean.chance(5, 10);
        expect(value || !value, equals(true)); 
        
        value = RandomBoolean.chance(5, 5);
        expect(value || !value, equals(true)); 
        
        value = RandomBoolean.chance(0, 0);
        expect(!value, equals(true)); 
        
        value = RandomBoolean.chance(-1, 0);
        expect(!value, equals(true)); 
        
        value = RandomBoolean.chance(-1, -1);
        expect(!value, equals(true)); 
    });

  });
}