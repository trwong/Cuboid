require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
  
  subject { Cuboid.new(0, 0, 0, 2, 3, 4) }

  describe "initialize" do
    it "with origin and dimensions" do
      origin_x = 1
      origin_y = 2
      origin_z = 3
      length = 4
      width = 5
      height = 6
      cube = Cuboid.new(origin_x, origin_y, origin_z, length, width, height)

      expect(cube.origin_x).to eq origin_x
      expect(cube.origin_y).to eq origin_y
      expect(cube.origin_z).to eq origin_z
      expect(cube.length).to eq length
      expect(cube.width).to eq width
      expect(cube.height).to eq height
    end

    context "raises an error with negative" do
      it "length" do
        expect { Cuboid.new(0, 0, 0, -1, 1, 1) }.to raise_error
      end

      it "width" do
        expect { Cuboid.new(0, 0, 0, 1, -1, 1) }.to raise_error
      end

      it "height" do
        expect { Cuboid.new(0, 0, 0, 1, 1, -1) }.to raise_error
      end
    end

    context "raises an error with zero" do
      it "length" do
        expect { Cuboid.new(0, 0, 0, 0, 1, 1)}.to raise_error
      end
      
      it "width" do
        expect { Cuboid.new(0, 0, 0, 1, 0, 1)}.to raise_error
      end
      
      it "height" do
        expect { Cuboid.new(0, 0, 0, 1, 1, 0)}.to raise_error
      end
    end
  end

  describe "move_to" do
    it "changes the origin in the simple happy case" do
      new_x = 3
      new_y = 4
      new_z = 5
      subject.move_to!(new_x, new_y, new_z)

      expect(subject.origin_x).to eq new_x
      expect(subject.origin_y).to eq new_y
      expect(subject.origin_z).to eq new_z
    end
  end    
  
  describe "vertices" do
    it "returns 8 values" do
      expect(subject.vertices.length).to eq 8
    end

    it "returns the correct values" do
      vertices = subject.vertices
      testVertices = [
        [0, 0, 0],
        [2, 0, 0],
        [0, 3, 0],
        [0, 0, 4],
        [2, 3, 0],
        [2, 0, 4],
        [0, 3, 4],
        [2, 3, 4],
      ]
      testVertices.each do |vertex|
        expect(vertices).to include(vertex)
      end
    end
  end

  describe "intersects?" do
    context "returns false" do
      it "when the cubes are not intersecting" do
        cubeA = Cuboid.new(0, 0, 0, 1, 1, 1)
        cubeB = Cuboid.new(4, 4, 4, 2, 3, 4)

        expect(cubeA.intersects?(cubeB)).to be false
      end
    end

    context "returns true" do
      it "when a cube is enveloped" do
        cubeA = Cuboid.new(0, 0, 0, 4, 4, 4)
        cubeB = Cuboid.new(1, 1, 1, 1, 1, 1)

        expect(cubeA.intersects?(cubeB)).to be true
      end

      it "when a cube is overlapping" do
        cubeA = Cuboid.new(0, 0, 0, 4, 4, 4)
        cubeB = Cuboid.new(3, 0, 0, 3, 3, 3)

        expect(cubeA.intersects?(cubeB)).to be true
      end

      it "when the corners are overlapping" do
        cubeA = Cuboid.new(0, 0, 0, 4, 4, 4)
        cubeB = Cuboid.new(3, 3, 3, 4, 4, 4)

        expect(cubeA.intersects?(cubeB)).to be true
      end
    end
  end

  describe "rotate!" do
    it "rotates a cube on its x axis" do
      subject.rotate!(:x)

      expect(subject.length).to eq 2
      expect(subject.width).to eq 4
      expect(subject.height).to eq 3
    end

    it "rotates a cube on its y axis" do
      subject.rotate!(:y)
      
      expect(subject.length).to eq 4
      expect(subject.width).to eq 3
      expect(subject.height).to eq 2
    end

    it "rotates a cube on its z axis" do
      subject.rotate!(:z)
      
      expect(subject.length).to eq 3
      expect(subject.width).to eq 2
      expect(subject.height).to eq 4
    end
  end
end