require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:pictures)
end
