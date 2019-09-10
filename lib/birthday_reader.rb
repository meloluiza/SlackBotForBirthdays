class BirthdayReader
  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  def self.file_exist?
    return (@@filepath and File.exist?(@@filepath))
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exist?(@@filepath)
    return false unless File.readable?(@@filepath)
    return true
  end

  def self.create_file
    File.open(@@filepath, 'w') unless file_exist?
    return file_usable?
  end

  def import_line(line)
    line_array = line.split(' ')
    @first_name, @last_name, @year, @month, @day = line_array
    return line_array
  end

  def self.get_birthdays
    birthdays = []

    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        birthdays << BirthdayReader.new.import_line(line.chomp)
      end
      file.close

      print "Parsing names and birthdays (count=#{birthdays.length})\n"
    else
      abort 'ERROR: Birthday file is not usable'
    end

    return birthdays
  end
end
