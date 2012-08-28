require "spec_helper"

  describe Desktop do
    let!(:desktop){ FactoryGirl.create :desktop }

    it { should belong_to :room }
    it { should belong_to :user }
    it { should have_one(:workplace).dependent(:nullify) }

    it { should validate_uniqueness_of(:ip) }
    it { should validate_presence_of(:ip) }
    it { should validate_uniqueness_of(:mac) }
    it { should validate_presence_of(:mac) }
    it { should validate_uniqueness_of(:user_id) }
    it { should validate_presence_of(:name) }

    #validates :ip,  :presence => true, :uniqueness => true, :format => {:with => /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/, :massage => 'Wrong IP'}
    #validates :mac, :presence => true, :uniqueness => true, :format => {:with => /\b([A-Fa-f0-9]{2}[:-]){5}[A-Fa-f0-9]{2}\b/, :massage => 'Wrong MAC'}
    #validates :user_id, :uniqueness => true, :if => :user_id?
    #validates :name, :presence => true
  end