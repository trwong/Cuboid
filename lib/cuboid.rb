require 'byebug'

class Cuboid  
  #BEGIN public methods that should be your starting point
  attr_reader :origin_x, :origin_y, :origin_z, :length, :width, :height

  # Initializes a cuboid with an origin which is the corner with the smallest x, y and z
  # as well as length, width and height. Will raise an error with zero and negative values
  # for its dimensions
  def initialize(origin_x, origin_y, origin_z, length, width, height)
    @origin_x = origin_x
    @origin_y = origin_y
    @origin_z = origin_z
    @length = length
    @width = width
    @height = height

    if length <= 0 || width <= 0 || height <= 0
      raise "dimensions cannot be negative or zero" 
    end
  end

  # Sets the cuboid's origin to a new value
  def move_to!(x, y, z)
    @origin_x = x
    @origin_y = y
    @origin_z = z
  end
  
  # Returns the 8 vertices of a  cuboid
  def vertices
    result = [[@origin_x, @origin_y, @origin_z]]
    dimensions = [@length, @width, @height]
    
    dimensions.each_with_index do |dimension, index|
      temp = result[0].dup
      temp[index] += dimension
      result << temp
      (index...dimensions.length).each do |index2|
        next if index == index2
        temp2 = temp.dup
        temp2[index2] += dimensions[index2]
        result << temp2
      end
    end
    result << [@origin_x + @length, @origin_y + @width, @origin_z + @height]
    result
  end
  
  # Checks if two cubes are completely past each other in at least one axis
  # otherwise the two cubes intersect
  def intersects?(other)
    return false if self.xMax < other.xMin
    return false if self.xMin > other.xMax
    return false if self.yMax < other.yMin
    return false if self.yMin > other.yMax
    return false if self.zMax < other.zMin
    return false if self.zMin > other.zMax
    true
  end

  # Modifies the dimensions to rotate the cuboid
  def rotate!(axis = :x)
    case axis
    when :x
      self.move_to!(@origin_x, @origin_y, @origin_z + @height)
      @width, @height = @height, @width
    when :y
      self.move_to!(@origin_x + @height, @origin_y, @origin_z)
      @length, @height = @height, @length
    when :z
      self.move_to!(@origin_x + @width, @origin_y, @origin_z)
      @width, @length = @length, @width
    end
  end

  protected
  # Helper methods to keep intersects? method clear
  def xMax
    @origin_x + length
  end
  
  def xMin
    @origin_x
  end
  
  def yMax
    @origin_y + width
  end
  
  def yMin
    @origin_y
  end
  
  def zMax
    @origin_z + height
  end

  def zMin
    @origin_z
  end
end