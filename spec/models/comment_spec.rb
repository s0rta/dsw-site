require 'spec_helper'

describe Comment do
  it { should belong_to(:submission).touch(true) }
end
