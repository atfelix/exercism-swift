struct Phrase {
    let verb: String
    let noun: String

    private init(verb: String, noun: String) {
        self.verb = verb
        self.noun = noun
    }

    static let all = [
        Phrase(verb: "", noun: ""),
        Phrase(verb: "lay in", noun: "the house that Jack built"),
        Phrase(verb: "ate", noun: "the malt"),
        Phrase(verb: "killed", noun: "the rat"),
        Phrase(verb: "worried", noun: "the cat"),
        Phrase(verb: "tossed", noun: "the dog"),
        Phrase(verb: "milked", noun: "the cow with the crumpled horn"),
        Phrase(verb: "kissed", noun: "the maiden all forlorn"),
        Phrase(verb: "married", noun: "the man all tattered and torn"),
        Phrase(verb: "woke", noun: "the priest all shaven and shorn"),
        Phrase(verb: "kept", noun: "the rooster that crowed in the morn"),
        Phrase(verb: "belonged to", noun: "the farmer sowing his corn"),
        Phrase(verb: "", noun: "the horse and the hound and the horn")
    ]
}
