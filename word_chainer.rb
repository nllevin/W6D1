class WordChainer
    attr_reader :dictionary, :all_seen_words
    attr_accessor :current_words

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

    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}

        explore_current_words until current_words.empty? || all_seen_words.include?(target)
        build_path(target)
    end
    
    def explore_current_words
        new_current_words = []
        current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                next if all_seen_words.include?(adjacent_word)
                new_current_words << adjacent_word
                all_seen_words[adjacent_word] = current_word
            end
        end
        self.current_words = new_current_words
        #new_current_words.each{|new_word| puts new_word + " <- " + all_seen_words[new_word]}
    end

    def build_path(target)
        path = []
        current_word = target
        until current_word.nil?
            path << current_word
            current_word = @all_seen_words[current_word]
        end
        path.reverse
    end
end