require "spec_helper"

  describe Room do
    it { should have_many :desktops }
    it { should have_many :desktops }
    it { should have_many :users }
    it { should have_many :workplaces }
  end