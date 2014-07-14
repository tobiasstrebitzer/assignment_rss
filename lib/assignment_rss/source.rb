require 'rss'

module AssignmentRss
  class Source
  	attr_reader :url, :max_age, :feed_class, :entry_class, :title, :rss_feed_entries
  	# attr_accessor :title, :rss_feed_entries

    # This is where the party starts
    def initialize(*args)
    	@url, @max_age, @feed_class, @entry_class, @title, @rss_feed_entries = args
    end

    def get_feed
    	open(@url) do |rss|
    		feed = RSS::Parser.parse(rss)
    		# @title = feed.entry.title
    		rss_feed_enties = feed.entry
    	end
    	cached = true
    	create_feed(feed)
    	rss_feed_entries.each do |rfe|
	    	create_feed_entries(rfe)
    	end
    end

    def cached
    	false
    end

    def create_feed(feed)
    	@feed = RssFeed.new do |rf|
    		rf.feed_id = feed.id
    		rf.url = @url
    		rf.title = feed.title
    		rf.link = feed.link
    		rf.rss_updated = feed.updated
    		rf.cache = true
    	end
    	@feed.save
    end

    def create_feed_entries(entries)
    	@rss_feed_entries = RssFeedEntry.new do |re|
		re.entry_id = entries.id
		re.title = entries.title
		re.author = entries.author.name
		re.link = entries.link
		re.rss_updated = entries
		re.content = entries.content
		re.rss_feed_id = entries
	  end
    	@rss_feed_entries.save
    end

  end
end