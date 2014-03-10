Gem::Specification.new do |s|
  s.name        = 'assignment_rss'
  s.version     = '0.1.0'
  s.date        = '2014-03-07'
  s.summary     = "Assignment Task: RSS- Parser"
  s.description = "A simple cached RSS datasource provider"
  s.authors     = ["Tobias Strebitzer"]
  s.email       = 'tobias.strebitzer@magloft.com'
  s.files       = ["lib/assignment_rss.rb"]
  s.homepage    =
    'http://www.magloft.com'
  s.license       = 'MIT'
  
  s.add_dependency "simple-rss"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "activesupport"
  s.add_development_dependency "sqlite3"
  
end