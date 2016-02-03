class Definer
  def define(word)
    base_url = 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml'
    word_lookup_url = "#{base_url}/#{word}?key=#{ENV['DICTIONARY_KEY']}"
    doc = Nokogiri::HTML(open(word_lookup_url))
    definition = doc.xpath('//def//dt').first.content
    "#{word}: #{definition}"
  end
end
