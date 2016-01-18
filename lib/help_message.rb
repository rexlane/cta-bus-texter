class HelpMessage

  def sorry
    "Sorry, I don't understand."
  end

  def base_help_message
    "Try one of these:"
  end

  def bus_help
    "BUS [location] [direction]"
  end

  def define_help
    "DEFINE [word]"
  end

  def map_help
    "MAP [location]"
  end

  def all_help
    "#{base_help_message}\n'#{bus_help}'\n'#{map_help}'\n'#{define_help}'\n"
  end

  def no_matching_method 
    "#{sorry} #{all_help}"
  end

end