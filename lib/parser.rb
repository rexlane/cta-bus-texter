class Parser
  def existing_methods
    %w(map define bus helpme)
  end

  def parse_method_name(split_string)
    permitted_method(split_string[0].downcase)
  end

  def parse_arguments(split_string)
    arguments = split_string[1].downcase if split_string[1]
    arguments
  end

  def parse_incoming_string(string)
    split_string = string.split(' ', 2)
    method_name = parse_method_name(split_string)
    arguments = parse_arguments(split_string)
    send(method_name, arguments)
  end

  def permitted_method(method_name)
    return method_name if existing_methods.include? method_name
    'no_matching_method'
  end

  # rename to something not 'map'
  def map(args)
    return [HelpMessage.new.no_matching_method, nil] if args.nil?
    Mapper.new.map(args)
  end

  def define(args)
    return [Definer.new.define(args), nil] unless args.nil?
    [HelpMessage.new.no_matching_method, nil]
  end

  def bus(args)
    return [HelpMessage.new.no_matching_method, nil] if args.nil?
    [BusTracker.new.bus(args), nil]
  end

  def helpme(*)
    [HelpMessage.new.all_help, nil]
  end

  def no_matching_method(*)
    [HelpMessage.new.no_matching_method, nil]
  end
end
