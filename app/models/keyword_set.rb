class KeywordSet
  include ActiveRecord::Validations
  attr_accessor :keywords
  
  validate :all_keywords_ok
  
  def all_keywords_ok
    keywords.each {|k| keywords.add(k.error) unless k.valid?}
  end
  
  def save
    keywords.all?(&:save)
  end
  
  def keywords=(incoming_data)
    @keywords = []
    incoming_data.split("\r\n").each do |k|
      @keywords << Keyword.new(:word => k) unless Keyword.where(word: k).count > 0
    end
  end
  
  def keywords
    @keywords
  end
end
