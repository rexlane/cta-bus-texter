class Parser

  EXISTING_METHODS = ["map","define"]
  
  def parse_incoming_string(string)
    request = string.split(" ", 2)
    requested_method = request[0].downcase
    
    if request[1]
      requested_arguments = request[1].downcase
    end

    if requested_method && requested_arguments
      method_name = permitted_method(requested_method)
    else
      method_name = "no_matching_method"
    end

    return method_name, requested_arguments

  end

  def permitted_method(requested_method)
    if EXISTING_METHODS.include? requested_method
      return requested_method
    else
      "no_matching_method"
    end
  end

end