# frozen_string_literal: true

# the display for all of the interactions
module Interface
  RESET = "\x1b[39;49;00m"
  RED = "\x1b[31;01m"
  GREEN = "\x1b[32;01m"
  YELLOW = "\x1b[33;01m"
  BOLD = "\x1b[37;01m"
  BOLD_N_UNDERLINE = "\x1b[4;01m"

  RED_BG = "\x1b[91;1m"
  GREEN_BG = "\x1b[92;1m"
  YELLOW_BG = "\x1b[93;1m"
  BLUE_BG = "\x1b[94;1m"
  MAGENTA_BG = "\x1b[95;1m"
  CYAN_BG = "\x1b[96;1m"

  def render_text(text = nil)
    print "\x1b[2J\x1b[H"
    starting_msg
    print text unless text.nil?
  end

  def starting_msg
    puts <<~HEREDOC
      #{BOLD}----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
          • ▌ ▄ ·.  ▄▄▄· .▄▄ · ▄▄▄▄▄▄▄▄ .▄▄▄  • ▌ ▄ ·. ▪   ▐ ▄ ·▄▄▄▄
          ·██ ▐███▪▐█ ▀█ ▐█ ▀. •██  ▀▄.▀·▀▄ █··██ ▐███▪██ •█▌▐███· ██
          ▐█ ▌▐▌▐█·▄█▀▀█ ▄▀▀▀█▄ ▐█.▪▐▀▀▪▄▐▀▀▄ ▐█ ▌▐▌▐█·▐█·▐█▐▐▌▐█▪ ▐█▌
          ██ ██▌▐█▌▐█▪ ▐▌▐█▄▪▐█ ▐█▌·▐█▄▄▌▐█•█▌██ ██▌▐█▌▐█▌██▐█▌██. ██
          ▀▀  █▪▀▀▀ ▀  ▀  ▀▀▀▀  ▀▀▀  ▀▀▀ .▀  ▀▀▀  █▪▀▀▀▀▀▀▀▀ █▪▀▀▀▀▀•
      ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----#{RESET}
    HEREDOC
  end

  def prompt(question)
    print "\n#{YELLOW}[ Q ]#{RESET} #{question} [Enter 'q' to quit]#{YELLOW} ⇒  #{RESET}"
    input = gets.chomp
    exit if input =~ /(q|quit)/i
    input
  end

  def show_result(message, pass)
    puts "\n#{pass ? GREEN : RED}[ ¶ ]#{RESET} #{message}"
  end

  def header(text)
    "#{BOLD_N_UNDERLINE}#{text}#{RESET}"
  end

  def computer_prompt(message, prompt)
    puts "\n#{YELLOW}[ G ]#{RESET} #{message}#{YELLOW} ⇒  #{RESET}#{prompt}"
  end

  def piece(number)
    case number
    when 1 then "#{RED_BG}[ 1 ]#{RESET}"
    when 2 then "#{GREEN_BG}[ 2 ]#{RESET}"
    when 3 then "#{YELLOW_BG}[ 3 ]#{RESET}"
    when 4 then "#{BLUE_BG}[ 4 ]#{RESET}"
    when 5 then "#{MAGENTA_BG}[ 5 ]#{RESET}"
    when 6 then "#{CYAN_BG}[ 6 ]#{RESET}"
    end
  end

  def clue_piece(piece)
    case piece
    when "*" then "\x1b[91m\u25CF\x1b[0m"
    when "?" then "\x1b[37m\u25CB\x1b[0m"
    end
  end
end
