MetaSearch::Where.add :between, :btw,
  :predicate => :in,
  :types => [:integer, :float, :decimal, :date, :datetime, :timestamp, :time],
  :formatter => Proc.new {|param| Range.new(param.to_datetime.midnight, param.to_datetime.end_of_day)},
  :validator => Proc.new {|param| !(param.blank?) }