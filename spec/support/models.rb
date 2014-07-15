require 'active_record'
load File.dirname(__FILE__) + '/schema.rb'

class RssFeed < ActiveRecord::Base
  has_many :rss_feed_entries

  def cached
  	self.cache
  end

end

class RssFeedEntry < ActiveRecord::Base
  belongs_to :rss_feed
end
