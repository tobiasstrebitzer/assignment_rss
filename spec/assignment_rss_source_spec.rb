require 'spec_helper'

# This test suite provides a briefing of what needs to be implemented.
#
# General Description: 
#   We want to create a gem that abstracts an RSS-Feed (with its entries) and save them as an
#   ActiveRecord object into the database. By doing so, we are able to (1) only download a feed once in the set cache lifetime, 
#   and (2) also will lateron be able to use the classic rails active-record logic to e.g. fetch only specific entries of an
#   rss feed, search through all feed entries, etc...
#
# Tips and Suggestions:
#   1) Use any gem that you prefer to help you with any underlying functionality. For example, don't write a custom RSS-Parser,
#      but instead use one of the existing RSS-Parser gems available. There's no limitation in what gems you may use for this.
#   2) For this assignment, we are interested only in the fields that are specified in the models (see rails/db/schema.rb for reference).
#   3) Different RSS-Feeds might not always provide the same value keys for where they store certain attributes. For example,
#      one RSS Feed might use the 'description'- key for its content, while others might use 'content', 'content_encoded' or whatsoever.
#      Think about a creative way to allow easy customization for this 'mapping'.
#   4) We have provided a functional rails- app that incorporates the gem, but it might require changes. Feel free to update the
#      Rails-App if you find there's anything to remove, simplify or improve. Still, the focus should be on the gem.
#   5) Quality before speed: Although time/speed/efficiency should be considered, quality of the code is way more important.
#      If you can't finish all of the gem, focus on what you've already accomplished.
#   6) The tests are written for just one specific rss-feed. Still, it should work with the additional feed-sources. Feel free
#      to add/modify any tests.
#   7) In this test-suite, the 'test- database' gets recreated after every test step - just to avoid any confusion.
#

# Case 1
# test_feed_url = 'http://weblog.rubyonrails.org/feed/atom.xml'
# test_feed_title = 'Riding Rails'

# Case 2
test_feed_url = 'http://localhost/rss/botd.wordpress.com'
test_feed_title = 'WordPress.com Top Posts'


describe AssignmentRss::Source do
  
  # Upon instantiation of a AssignmentRss::Source, all configuration options
  # (url, cache-lifetime, ActiveRecord-rss-feed-class and ActiveRecord-rss-feed-entry-class) 
  # should be stored in the source object.
  # The source should not automatically start downloading any data.
  it 'should initialize a data source' do
    source = AssignmentRss::Source.new(test_feed_url, 10.minutes, RssFeed, RssFeedEntry)
    source.url.should == test_feed_url
    source.max_age.should == 10.minutes
    source.feed_class.should == RssFeed
    source.entry_class.should == RssFeedEntry
  end

  # After instantiation, the feed can be received by calling the 'get_feed' method. By doing so, the RSS-Feed will be
  # downloaded and parsed. Next, one RssFeed- Object will be created and saved instantly. It is the representation of
  # the feed itself, with a title, modification date, id, etc...
  # Additionally, for each entry/item in the feed, a RssFeedEntry object will be created and saved instantly.
  # Consider: The return value of get_feed is only the RssFeed object... the relation between rss-feed and entry is
  # provided using the activerecord relation (see rails/db/schema.rb for reference).
  it 'should download a feed' do
    # The first result will be downloaded from the feed url (uncached)
    source = AssignmentRss::Source.new(test_feed_url, 10.minutes, RssFeed, RssFeedEntry)
    source.cached.should === false
    feed = source.get_feed
    feed.title.should == test_feed_title
  end

  # Once a feed has already been downloaded (first-time-call), the second call of get_feed should instead fetch the existing
  # records from the database (cached) and return the result. The 'cached' attribute of the data source indicates if
  # the get_feed result will be received from cache (true), or downloaded from the RSS-Feed source (false).
  it 'should get a cached result when run the second time' do
    
    # The first result will be downloaded from the feed url (uncached)
    source1 = AssignmentRss::Source.new(test_feed_url, 10.minutes, RssFeed, RssFeedEntry)
    source1.cached.should === false
    feed1 = source1.get_feed
    feed1.title.should == test_feed_title
    
    # The second result will be fetched from the database (cached)
    source2 = AssignmentRss::Source.new(test_feed_url, 10.minutes, RssFeed, RssFeedEntry)
    source2.cached.should === true
    feed2 = source2.get_feed
    feed2.title.should == test_feed_title
    
  end

  # The activerecord- objects should have valid attributes (at least a title).
  it 'should create a valid object' do
    # The first result will be downloaded from the feed url (uncached)
    source = AssignmentRss::Source.new(test_feed_url, 10.minutes, RssFeed, RssFeedEntry)
    source.cached.should === false
    feed = source.get_feed
    feed.title.should == test_feed_title
    
    entries = feed.rss_feed_entries
    entries.length.should > 0
    entries[0].title.class.should == String

  end
 
end
