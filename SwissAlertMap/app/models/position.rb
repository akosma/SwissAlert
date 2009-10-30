class Position < ActiveRecord::Base

  MAX_CODE_LENGTH = 6
  INVALIDATION_TIME_DAYS = 50

  def self.recent
    today = Time.new
    seconds = INVALIDATION_TIME_DAYS * 24 * 60 * 60
    Position.find(:all, :conditions => ["created_at > ?", today - seconds])
  end

  def save
    if self.new_record?
      if code_exists?
        create_code
      end
    end
    super
  end
  
  def info_window
    "<strong><a href=\"#{code}\">#{code}</a></strong><br/>created on " + creation_time
  end
  
  def creation_time
    created_at.to_s(:long)
  end
  
  def caption
    code
  end
  
  def url
    code
  end

private
  
  def code_exists?
    self.code.nil? || self.code.length < 3 || Position.exists?(:code => code)
  end

  def create_code
    # Code adapted from
    # http://travisonrails.com/2007/06/07/Generate-random-text-with-Ruby
    chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    while code_exists? do
      result = ''  
      rand(MAX_CODE_LENGTH).times { |i| result << chars[rand(chars.length)] }
      self.code = result
    end

    # Spell the code so that it's easier to read on the phone
    alphabet = %w[ Alpha Bravo Charlie Delta Echo Foxtrot 
                    Golf Hotel India Juliet Kilo Lima Mike 
                    November Oscar Papa Quebec Romeo Sierra 
                    Tango Uniform Victor Whiskey Xray Yankee Zulu ]
    array = []
    (0..self.code.length - 1).to_a.each do |i| 
      array << alphabet[self.code[i] - 65] 
    end
    self.spell = array.join(" ")
  end

end
