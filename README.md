# fuzzaldrin

Fuzzy filtering and string scoring (ported to haxe from https://github.com/atom/fuzzaldrin).

The original library is used by [Atom](http://atom.io) and so its focus will be on
scoring and filtering paths, methods, and other things common when writing code.
It therefore will specialize in handling common patterns in these types of
strings such as characters like `/`, `-`, and `_`, and also handling of
camel cased text.

## Using

```sh
haxelib install fuzzaldrin
```

### Fuzzaldrin.filter(candidates, query, [options])

Sort and filter the given candidates by matching them against the given query.

* `candidates` - An array of strings or objects.
* `query` - A string query to match each candidate against.
* `options` - An optional object with the following keys:
  * `key` - The property to use for scoring if the candidates are objects.
  * `maxResults` - The maximum numbers of results to return.

Returns an array of candidates sorted by best match against the query.

```haxe
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
```

### Fuzzaldrin.score(string, query)

Score the given string against the given query.

* `string` - The string the score.
* `query` - The query to score the string against.

```haxe
import fuzzaldrin.Fuzzaldrin;

class Main {
    static function main() {
        Fuzzaldrin.score('Me', 'me')    // 0.17099999999999999
        Fuzzaldrin.score('Maybe', 'me') // 0.0693
    }
} 
```
