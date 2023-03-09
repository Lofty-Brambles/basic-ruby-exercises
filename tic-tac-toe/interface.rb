# frozen_string_literal: true

# the I/O messages that helps the game interact
module Interface
  RESET = "\x1b[39;49;00m"
  RED = "\x1b[31;01m"
  GREEN = "\x1b[32;01m"
  YELLOW = "\x1b[33;01m"
  BOLD = "\x1b[37;01m"

  def render_text(text = nil)
    print "\x1b[2J\x1b[H"
    starting_msg
    print text unless text.nil?
  end

  def starting_msg
    puts <<~HEREDOC
      #{BOLD}----- ----- ----- ----- ----- ----- ----- ----- ----- -----
          ▄▄▄▄▄▄▪   ▄▄·   ▄▄▄▄▄▄ ▄▄▄·  ▄▄·   ▄▄▄▄▄▄      ▄▄▄ .
          ▀•██ ▀██ ▐█ ▌▪  ▀•██ ▀▐█ ▀█ ▐█ ▌▪  ▀•██ ▀ ▄█▀▄ ▀▄.▀·
            ▐█.▪▐█·██ ▄▄    ▐█.▪▄█▀▀█ ██ ▄▄    ▐█.▪▐█▌.▐▌▐▀▀▪▄
            ▐█▌·▐█▌▐███▌    ▐█▌·▐█▪ ▐▌▐███▌    ▐█▌·▐█▌.▐▌▐█▄▄▌
            ▀▀▀ ▀▀▀·▀▀▀     ▀▀▀  ▀  ▀ ·▀▀▀     ▀▀▀  ▀█▄▀▪ ▀▀▀
      ----- ----- ----- ----- ----- ----- ----- ----- ----- -----#{RESET}
    HEREDOC
  end

  def prompt(question)
    print "\n#{YELLOW}[ Q ]#{RESET} #{question}#{YELLOW} ⇒  #{RESET}"
    gets.chomp
  end

  def show_error(error_msg)
    puts "#{RED}[ E ]#{RESET} #{error_msg}"
  end

  def show_result(message)
    puts "\n#{GREEN}[ ¶ ]#{RESET} #{message}"
  end

  # rubocop:disable Metrics/AbcSize

  def show_board(board, player1, player2)
    render_text
    array = board.display_proof_board
    puts <<~HEREDOC

         |   |
       #{array[0][0]} | #{array[0][1]} | #{array[0][2]}
      ---|---|---
       #{array[1][0]} | #{array[1][1]} | #{array[1][2]}
      ---|---|---
       #{array[2][0]} | #{array[2][1]} | #{array[2][2]}
         |   |

      #{player1} (#{board.symbols[0]}) vs. #{player2} (#{board.symbols[1]})
    HEREDOC
  end

  # rubocop:enable Metrics/AbcSize
end
