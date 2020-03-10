import fuzzaldrin.Fuzzaldrin;

class Main {
	static function main() {
		
        // With an array of strings
        var candidates = ['Call', 'Me', 'Maybe'];
        var results = Fuzzaldrin.filter(candidates, 'me');
        trace(results); // ['Me', 'Maybe']

        // With an array of objects
        var candidates = [
            { name: 'Call', id: 1 },
            { name: 'Me', id: 2 },
            { name: 'Maybe', id: 3 }
        ];
        var results = Fuzzaldrin.filter(candidates, 'me', { key: 'name' });
        trace(results); // [{ name: 'Me', id: 2 }, { name: 'Maybe', id: 3 }]
	}
}
