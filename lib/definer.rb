class Definer

  def define(word)
    dictionary_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}?key=#{ENV["DICTIONARY_KEY"]}"
    doc = Nokogiri::HTML(open(dictionary_url))
    definition = doc.xpath("//def//dt").first.content
    definition = "#{word}: #{definition}"
  end

end