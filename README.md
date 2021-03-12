A class that allows to store Ruby strings with interpolations waiting to be interpolated.

Example code:

    # Note the single quotes! Double quotes would use Ruby's native interpolation.
    str = 'This #{adjective} class can interpolate: #{interpolation}.'

    str = StringInterpolator.new(str)
    str.adjective = 'awesome'
    str.interpolation = 'like this'

    new_str = str.get
    p new_str.class # => String
    p new_str # => "This awesome class can interpolate: like this."

I wrote this class while trying to solve the "99 bottles" problem, as seen is Sandi Metz's book "99 Bottles of OOP".

    # Markdown escapes all slashes for some reason
    verse = "\#{num} bottles of beer on the wall, " \
        "\#{num} bottles of beer.\n" \
        'Take one down and pass it around, ' \
        "\#{num_minus_one} bottles of beer on the wall.\n"
    verse = StringInterpolator.new(verse)

    99.downto(10).each do |num|
      verse.num = num
      verse.num_minus_one = num - 1
      puts verse.interpolate
    end
    # This isn't the solution to the actual problem; It just shows a use case.