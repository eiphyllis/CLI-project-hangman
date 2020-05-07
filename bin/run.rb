require_relative '../config/environment'


# METHODS #
$the_answer = " "

$num_guesses = 10
$guesses_remaining = 10 
$answer_array = []
$progress_answer = []
$current_game
$current_user
$already_guessed = []
$prompt = TTY::Prompt.new

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
    puts "Welcome to hangman!"
    menu 
    puts "See you next time!"
end

def menu
    category = $prompt.select("Choose a new game or scoreboard from the menu", %w(New Scoreboard Mygames Help Quit))
    if category == "New"
        new_game
    elsif category == "Scoreboard"
        Score.top_scores 
        menu
    elsif category == "Mygames"
        ask_name
        wins 
        losses
        menu 
    elsif category == "Help"
        print "instructions: Hangman is a word guess game.
         Enter a letter and if it's in the word, the terminal will reveal the corresponding spaces in the word.
         Between letter guesses, You will have the opportunity to guess the whole word.
         If you run out of guesses, you lose.
         Type exit then press enter while playing the game if you want to exit."
        menu
    else
        exit
    end
end

def new_game
    user_name = $prompt.ask("What is your name?")
    create_user(user_name)
    game_play
    menu
end

def ask_name
    user_name = $prompt.ask("What is your name?")
        if find_user(user_name)
            $current_user = find_user(user_name)
        else
            new_user = User.create
            new_user.name = user_name
            new_user.save
            $current_user = new_user
        end
end 

def create_user(user_name)
    if find_user(user_name)
        save_this_game(find_user(user_name))
        $current_user = find_user(user_name)
    else
        new_user = User.create
        new_user.name = user_name.downcase
        new_user.save
        save_this_game(new_user)
        $current_user = new_user
    end
end

def find_user(user_name)
    User.find_by_name(user_name)
end

def save_this_game(this_user)
    new_game = Game.create
    new_score = Score.create
    new_score.game_id = new_game.id
    new_score.save
    new_score.user_id = this_user.id
    new_score.save
    new_game.won = false
    new_game.save
    new_game.round = Time.now 
    new_game.save
    $current_game = new_game
end 

def game_play
    reset 
    save_this_game($current_user)
    random_word
    make_board
    word_board
    
    while !game_over
        make_letter_guess
    end
    if $progress_answer == $answer_array
        game_won 
    else 
        game_lost 
    end 
    $current_user = nil
    # exit
end 

def random_word
words = ["orientation", "git", "ruby", "orientation", "class", "instance", "method", "variable", "sql", "flatiron"]
    $the_answer = words.sample
end

def make_board
    $answer_array = $the_answer.split("")
    $the_answer.size.times do
        $progress_answer.push(" _ ")
    end
end 

def print_guesses
    if $already_guessed.size !=0
        print "So far, you have guessed the following: #{$already_guessed.join(', ')}..."
    end 
end 

def word_board
    puts $progress_answer.join
end

def want_word_guess
    response = $prompt.yes?("Do you want to guess the whole word?")
        if response == "exit"
            exit
        elsif response == true
             make_word_guess
        end 
end 

def make_word_guess
        puts "What do you think the word is?"
        guess = gets.chomp
        $already_guessed << guess
        if guess == "exit"
            exit
        elsif check_word_guess(guess)
            # game_won
        else
            puts "Survey says? ... No."
            move_to_next_round
        end   
end 

def make_letter_guess
    puts "#{print_guesses} Enter a letter guess:"
    guess = gets.chomp
    $already_guessed << guess
    if guess == "exit"
        exit
    elsif check_letter_guess(guess)
        if $progress_answer == $answer_array 
            #do nothing
        else
            print "Good guess! "
            move_to_next_round
        end 
    else
        print "Sorry, wrong guess :( " 
        move_to_next_round
    end

    if !game_over
    want_word_guess
    end 
end

def check_letter_guess(input)
    $progress_answer.each_with_index do |c, index|
        if $answer_array[index] == input
          $progress_answer[index] = input
          return true
        end
    end
    return false
end 

def check_word_guess(input)
    if $the_answer == input.strip
        $progress_answer = $answer_array
        return true 
    end 
    return false 
end 

def move_to_next_round
    one_less_guess
    word_board
end 

def one_less_guess
    $guesses_remaining -= 1 
    puts "You have #{$guesses_remaining} guess(es) left"
end 


def game_over
    if ($progress_answer == $answer_array) || ($guesses_remaining == 0)
        return true 
    else 
        return false 
    end 
end

def game_lost
    $current_game.won = false
    Score.find($current_game.id).update(score: 0)
    Game.find($current_game.id).update(won: 'false')
    response = $prompt.yes?("Awe too bad, the word was #{$the_answer}. Do you want to play again?")
    if response == true
        game_play
    end
end 

def game_won
    puts "WOW! You got it!"
    $current_game.won = true
    Game.find($current_game.id).update(won: 'true')
    Score.find($current_game.id).update(score: 10)
    
    response = $prompt.yes?("Congratulations! You won and guessed #{$the_answer} correctly! Do you want to play again?")
    if response == true
        game_play
    end
end 

def reset
    $the_answer = " "
    $guesses_remaining = 10 
    $answer_array = []
    $progress_answer = []
end

def wins
    wins = ActiveRecord::Base.connection.execute("SELECT DISTINCT users.name, COUNT(games.won) FROM users JOIN scores ON users.id = scores.user_id JOIN games ON games.id = scores.game_id  WHERE games.won = 't' GROUP BY user_id")
    my_wins = (wins.find do |win|
        win["name"] == $current_user.name
    end)
    if my_wins != nil 
        puts " You won #{my_wins["COUNT(games.won)"]} games so far."
    else 
        puts " You won 0 games so far."
    end 
end

def losses
    losses = ActiveRecord::Base.connection.execute("SELECT DISTINCT users.name, COUNT(games.won) FROM users JOIN scores ON users.id = scores.user_id JOIN games ON games.id = scores.game_id  WHERE games.won = 'f' GROUP BY user_id")
    my_losses = (losses.find do |loss|
        loss["name"] == $current_user.name
    end)
    if my_losses != nil 
        puts " You lost #{my_losses["COUNT(games.won)"]} games so far."
    else 
        puts " You lost 0 games so far."
    end 
end

start

puts "HELLO WORLD"
