require_relative '../config/environment'
# start

#METHODS#
$the_answer = " "

$num_guesses = 10
$guesses_remaining = 10 
$answer_array = $the_answer.split("")
$progress_answer = []
    
$prompt = TTY::Prompt.new

def random_word
words = ["git", "ruby", "orientation", "class", "instance", "method", "variable", "sql", "flatiron"]
    $the_answer = words.sample
end

def make_board
    $the_answer.size.times do
        $progress_answer.push(" _ ")
    end
end 

def word_board
    puts $progress_answer.join
end

def check_letter_guess(input)
    answer_array.each_with_index do |c, index| 
        if c == input
            $progress_answer[index] = input
        end
    end
    one_less_guess
end 

def game_lost
    if guesses_remaining == 0 
        response = $prompt.ask("Awe too bad, the word was #{$the_answer}. Do you want to play again? y/n")
        if response == "y"
            Game.start
        else
            # quit or exit
        end
    end
end 

def game_over
    check_word_guess || guesses == 0
end

def check_word_guess(input)
    if $the_answer == input.strip
        won 
        return true
    end 
end 

def one_less_guess
    guesses_remaining -= 1 
    puts "You have #{$guesses_remaining} guesses left"
end 

def won
    won = true 
    # puts "Congratulations! You won and guessed #{$the_answer} correctly!"
    Score.all.find do |score|
        score.game_id == self.id
    end.score = 10
end 

def make_guess
    if $guesses_remaining > 0
        puts "Enter a letter guess, your hint is ...."
        guess = gets.chomp
        if check_letter_guess(guess)
            puts "Good guess!"
        else
            puts "Sorry, wrong guess"
        end
        word_board
        make_guess
    else
        game_lost
    end
end

def menu
    category = $prompt.select("Choose a new game or scoreboard from the menu", %w(New Scoreboard My games Help Quit))
    if category == "New"
        new_game
    elsif category == "Scoreboard"
            # method for listing top games
    elsif category == "My games"
        # method for listing user's games
    elsif category == "Help"
        print "instructions"
    else
        quit
    end
end

def new_game
    random_word
    make_board
    word_board
end

def save_this_game
    current_game = Game.create
    new_score = Score.create
    new_score.game_id = current_game.id
    new_score.user_id = user.id
end 
def ask_name
    user_name = $prompt.ask("What is your name?")
    binding.pry
    
    if User.all.find do |user|
        user.name == user_name
        end
           save_this_game
    else
        new_user = User.create
        new_user.name = user_name
        save_this_game
    end 
end
def find_user(user_name)
    User.all.find do |user|
        user.name == user_name
    end
end

def start
puts " _    _"
puts "| |  | |"
puts "| |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __"
puts "|  __  |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\"
puts "| |  | | (_| | | | | (_| | | | | | | (_| | | | |"
puts "|_|  |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|"
puts "                     __/ |"
puts "                    |___/"
puts "\n"
# method that calls everything else
# welcome message
puts "Welcome to hangman!"
menu # menu
     #new_game: new instance of game with num_guesses and guesses_remaining fresh
         # generate random word  # save that word as the answer
    # answer_array = split that answer so we have something to iterate/compare
    # create progress_array that replaces all the chars in answer_array with _
ask_name
# while !game_over
         # single_play: 
                    # print progress_array and guesses_remaining left to terminal
                    # do you want to guess the word?
                        # if y
                            # check_word_guess(user_input)  
                                # if correct
                                   # word_guessed = true 
                    # ask user for a letter guess  
                    # user enters letter guess
                    # check their input against the answer_array
                        #if found, 
                            # say "getting closer"
                            #  "reveal" that index in the progress_array
                        #if not found, say "nope"
                    # decrement guesses_remaining

end


start
# binding.pry

puts "HELLO WORLD"
