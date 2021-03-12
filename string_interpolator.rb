class StringInterpolator
  def initialize(str)
    raise TypeError unless str.respond_to? :to_s

    str = str.to_s
    @str = str
    regex = /\#{(\S+)}/

    # Initialise all interpolations
    @interpolations = []
    @str.scan(regex)&.each do |interpolation_name|
      interpolation_name = interpolation_name.first if interpolation_name.is_a? Array
      singleton_class.attr_accessor interpolation_name.to_sym
      @interpolations << interpolation_name
    end
  end

  def get
    str = @str.dup
    @interpolations.each do |interpolation|
      with_brackets = "\#{#{interpolation}}"
      value = send(interpolation.to_sym) || ''
      str.gsub!(with_brackets, value.to_s)
    end

    str
  end
  alias interpolate get
end
