require 'minitest/autorun'
# Tests Bar class Below
class BarTest < Minitest::Test
  def test_ask_returns_an_answer
    bar = Bar.new('c', 120, 2, 1)
    assert bar
  end

  def test_number_of_key_c
    bar = Bar.new('c', 120, 2, 1)
    assert(bar.number_of_key == 0)
  end

  def test_number_of_key_b
    bar = Bar.new('b', 120, 2, 1)
    assert(bar.number_of_key == 11)
 end

  def test_prints_c_scale
    bar = Bar.new('c', 120, 2, 1)
    assert(bar.get_scale == %w[c d e f g a b])
  end

  def test_prints_cis_scale
    bar = Bar.new('cis', 120, 2, 1)
    assert(bar.get_scale == %w[cis dis f fis gis ais c])
  end

  def test_variations_c_1 
    bar=Bar.new('c',120 ,2 ,1)
    assert bar.get_numeric_variations[0]==([1, 1, 3, 5])
  end

  def test_variations_c_2
    bar=Bar.new('c',120 ,2 ,1)
    assert bar.get_numeric_variations[1]==([1, 3, 5, 1])
  end
  def test_variations_in_key_c_1
    bar=Bar.new('c',120 ,2 ,1)
    assert bar.get_variations_in_key[0]==(%w[c c e g])

end
  def test_variations_in_key_c_1_2
    bar=Bar.new('c',120 ,2 ,1)
    assert bar.get_variations_in_key[1]==(%w[c e g c])

end

end
# Bar plays melody with bpm and key
class Bar
  def initialize(key, bpm, beat, triad)
    @key = key
    @bpm = bpm
    @beat = beat
    @triad = triad
    @chromatic_scale = %w[c cis d dis e f fis g gis a ais b]
    @major_scale_numbers = [0, 2, 4, 5, 7, 9, 11]
    @scale=[]
    @variations_in_key=[]
  end

  def number_of_key
    @chromatic_scale.index(@key)
  end

  def get_scale
    @major_scale_numbers.each do |num|
      @scale.push(@chromatic_scale [(num + @chromatic_scale.index(@key)) % 12])
    end
    @scale
  end

  def get_numeric_variations
    x = [[@triad, @triad, (@triad + 2) % 7, (@triad + 4) % 7], [@triad, (@triad + 2) % 7, (@triad + 4) % 7, @triad], [@triad, (@triad + 4) % 7, @triad, (@triad + 2) % 7]]
  
    
    x.each do |notes|
      notes.each_with_index do |seven_check, i|
        
        notes[i] = 7 if seven_check == 0
      end
    end
  end

  def get_variations_in_key
    numeric_variations=get_numeric_variations
    get_scale
    numeric_variations.each_with_index do | variation, i  |
      p variation
      trichord=[]
      variation.each_with_index do | note , chord_index |
       note_to_push=@scale[note-1]
       p note_to_push
       trichord.push(note_to_push)
      end
      @variations_in_key.push(trichord)
    end
    p @variations_in_key
    @variations_in_key
  end
  
end

 
 

    #var_arr = []
    #notes.each do |tranlate|
    #  var_arr.push(c[tranlate - 1])
    #end
    #triad_arr.push(var_arr)
  



bar = Bar.new('cis', 120, 2, 7)

#p bar.get_numeric_variations
#bar.get_variations_in_key