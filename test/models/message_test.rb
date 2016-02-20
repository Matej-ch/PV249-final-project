require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to(:conversation)
  should belong_to(:user)

  test 'a message should have body' do
    message = Message.new
    assert !message.save
    assert !message.errors[:body].empty?
  end
end
