class WordChainer
    attr_reader :dictionary
    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name, chomp: true).to_set
    end

    def adjacent_words(word)
        alphabet = ("a".."z").to_a
        new_words = []

        (0...word.length).each do |i|
            alphabet.each do |letter|
                new_word = word.dup
                new_word[i] = letter

                new_words << new_word if dictionary.include?(new_word) && new_word != word
            end
        end
        new_words
    end
end