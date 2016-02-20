require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  should belong_to(:album)
  should belong_to(:user)
end
