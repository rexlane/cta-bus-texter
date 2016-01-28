class HelpMessage

  # def no_matching_method(body=nil)
  #   error_string = "Sorry, I don't understand. For help, reply \"HELPME\"."
  # end


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
    "#{base_help_message} #{bus_help}; #{map_help}; #{define_help}"
  end

  def no_matching_method 
    "#{sorry} #{all_help}"
  end

end