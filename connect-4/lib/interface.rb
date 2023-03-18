# frozen_string_literal: true

# this does not need testing as it simply exists to puts stuff

# the display for all of the interactions
module Interface
  RESET = "\x1b[39;49;00m"

  RED = "\x1b[31;01m"
  GREEN = "\x1b[32;01m"
  YELLOW = "\x1b[33;01m"
  BOLD = "\x1b[37;01m"

  RED_CIRCLE = "\x1b[31m\u25cf\x1b[0m"
  BLUE_CIRCLE = "\x1b[34m\u25cf\x1b[0m"
  BLANK_CIRCLE = "\u25cf"

  def render_text(text = nil)
    print "\x1b[2J\x1b[H"
    starting_msg
    print text unless text.nil?
  end

  def starting_msg
    puts <<~HEREDOC
      #{BOLD}----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
          ▄▄·        ▐ ▄  ▐ ▄ ▄▄▄ . ▄▄· ▄▄▄▄▄  ·▄▄▄      ▄• ▄▌▄▄▄  
         ▐█ ▌▪ ▄█▀▄ •█▌▐█•█▌▐█▀▄.▀·▐█ ▌▪•██    █  · ▄█▀▄ █▪██▌▀▄ █·
         ██ ▄▄▐█▌.▐▌▐█▐▐▌▐█▐▐▌▐▀▀▪▄██ ▄▄ ▐█.▪  █▀▀▪▐█▌.▐▌█▌▐█▌▐▀▀▄ 
         ▐███▌▐█▌.▐▌██▐█▌██▐█▌▐█▄▄▌▐███▌ ▐█▌·  ██ .▐█▌.▐▌▐█▄█▌▐█•█▌
         ·▀▀▀  ▀█▄▀▪▀▀ █▪▀▀ █▪ ▀▀▀ ·▀▀▀  ▀▀▀   ▀▀▀  ▀█▄▀▪ ▀▀▀ .▀  ▀
      ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----#{RESET}
    HEREDOC
  end

  def display_board(board, player1, player2)
    puts <<~HEREDOC
        #{board[0][5]}   #{board[1][5]}   #{board[2][5]}   #{board[3][5]}   #{board[4][5]}   #{board[5][5]}   #{board[6][5]}
        #{board[0][4]}   #{board[1][4]}   #{board[2][4]}   #{board[3][4]}   #{board[4][4]}   #{board[5][4]}   #{board[6][4]}
        #{board[0][3]}   #{board[1][3]}   #{board[2][3]}   #{board[3][3]}   #{board[4][3]}   #{board[5][3]}   #{board[6][3]}
        #{board[0][2]}   #{board[1][2]}   #{board[2][2]}   #{board[3][2]}   #{board[4][2]}   #{board[5][2]}   #{board[6][2]}
        #{board[0][1]}   #{board[1][1]}   #{board[2][1]}   #{board[3][1]}   #{board[4][1]}   #{board[5][1]}   #{board[6][1]}
        #{board[0][0]}   #{board[1][0]}   #{board[2][0]}   #{board[3][0]}   #{board[4][0]}   #{board[5][0]}   #{board[6][0]}
      -----------------------------
        1   2   3   4   5   6   7

        #{player1[:name]} [#{player1[:symbol]}] |VS| #{player2[:name]} [#{player2[:symbol]}]

    HEREDOC
  end

  def bolden(text)
    "#{BOLD}#{text}#{RESET}"
  end

  def prettify_question(question)
    "\n#{YELLOW}[ Q ]#{RESET} #{question}#{YELLOW} ⇒  #{RESET}"
  end

  def show_result(message, pass)
    puts "\n#{pass ? GREEN : RED}[ ¶ ]#{RESET} #{message}"
  end
end
