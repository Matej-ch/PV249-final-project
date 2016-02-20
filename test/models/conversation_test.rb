require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  should belong_to(:sender)
  should belong_to(:recipient)
  should have_many(:messages)
end
