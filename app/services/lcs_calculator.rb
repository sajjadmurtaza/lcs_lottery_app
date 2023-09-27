# frozen_string_literal: true

class LcsCalculator
  def self.calculate_lcs(str1, str2)
    # Convert the input strings into arrays of characters
    chars1 = str1.chars
    chars2 = str2.chars

    # Create a 2D array to store the LCS lengths
    lcs_lengths = Array.new(chars1.length + 1) { Array.new(chars2.length + 1, 0) }

    # Build the LCS lengths matrix using each_with_index
    chars1.each_with_index do |char1, i|
      chars2.each_with_index do |char2, j|
        if char1 == char2
          lcs_lengths[i + 1][j + 1] = lcs_lengths[i][j] + 1
        else
          lcs_lengths[i + 1][j + 1] = [lcs_lengths[i][j + 1], lcs_lengths[i + 1][j]].max
        end
      end
    end

    # Trace back to find the LCS itself
    i, j = chars1.length, chars2.length
    lcs = ''

    while i.positive? && j.positive?
      if chars1[i - 1] == chars2[j - 1]
        lcs = chars1[i - 1] + lcs
        i -= 1
        j -= 1
      elsif lcs_lengths[i - 1][j] > lcs_lengths[i][j - 1]
        i -= 1
      else
        j -= 1
      end
    end

    lcs
  end
end
