package fuzzaldrin;

class Filter {
    
	static function pluckCandidates(a) {
		return a.candidate;
	}

	static function sortCandidates(a, b):Int {
		if (b.score > a.score)
			return 1;
		else if (b.score < a.score)
			return -1;
		else
			return 0;
	}

	public static function filter(candidates:Array<Dynamic>, query:String, queryHasSlashes:Bool, ?options:{
		?key:String,
		?maxResults:Int
	}) {
		var key:String = options != null ? options.key : null;
		var maxResults:Int = options != null ? options.maxResults : -1;
		if (query != null && query.length > 0) {
			var scoredCandidates = [];
			for (i in 0...candidates.length) {
				var candidate = candidates[i];
				var string:String = key != null ? Reflect.getProperty(candidate, key) : candidate;
				if (string == null || string.length == 0) {
					continue;
				}
				var score = Scorer.score(string, query);
				if (!queryHasSlashes) {
					score = Scorer.basenameScore(string, query, score);
				}
				if (score > 0) {
					scoredCandidates.push({
						candidate: candidate,
						score: score
					});
				}
			}
			scoredCandidates.sort(cast sortCandidates);
			candidates = scoredCandidates.map(cast pluckCandidates);
		}
		if (maxResults != -1) {
			candidates = candidates.slice(0, maxResults);
		}
		return candidates;
    }
    
}
