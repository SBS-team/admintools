require "spec_helper"

  describe EventUser do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end