require "spec_helper"

  describe EventAdmin do
    it { should belong_to :admin }
    it { should belong_to :event }
  end