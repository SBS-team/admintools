require "spec_helper"

  describe Desktop do
    it { should belong_to(:room)  }
    it { should belong_to(:user) }
    it { should have_one(:workplace).dependent(:nullify)}
  end