TZ = "-03:00"

module TimeExtensions
  def current
    now.getlocal(TZ)
  end
end

Time.extend(TimeExtensions)
