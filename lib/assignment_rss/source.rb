require 'simple-rss'
require 'open-uri'

module AssignmentRss
  class Source
  	attr_reader :url, :max_age, :feed_class, :entry_class, :title, :rss_feed_entries
  	# attr_accessor :title, :rss_feed_entries

    # This is where the party starts
    def initialize(*args)
    	@url, @max_age, @feed_class, @entry_class, @title, @rss_feed_entries, @cache = args
    end

    def get_feed
    	# @feed = RssFeed.find_by_url(@url)
    	# if @feed.nil?
    	open(@url) do |rss|
    		feed = SimpleRSS.parse(rss)
    		# @title = feed.entry.title
    		rss_feed_entries = feed.feed.entries
    		@cache = true
    		create_feed(feed, @url)
                                rss_feed_entries.each do |rfe|
	    		create_feed_entries(rfe, feed.id)
                                end
	    	end

	    	feed = RssFeed.find_by_url(@url)
  #   	else
		# @feed
		# @cache = @feed.cache
  #   	end
    end

    def cached
    	@cache ||= false
    end

    def create_feed(feed, url)
    	@feed = RssFeed.new do |rf|
    		rf.feed_id = feed.id.to_s
    		rf.url = url.to_s
    		rf.title = feed.title.to_s
    		rf.link = feed.link.to_s
    		rf.rss_updated = Time.parse(feed.updated.to_s).to_datetime
    		rf.cache = true
    	end
    	@feed.save
    end

    def create_feed_entries(entries, feed_id)
    	@rss_feed_entries = RssFeedEntry.new do |re|
		re.entry_id = entries.id.to_s
		re.title = entries.title.to_s
		re.author = entries.author.to_s
		re.link = entries.link.to_s
		re.rss_updated = DateTime.parse(entries.updated.to_s).to_datetime
		re.content = entries.content.to_s
		re.rss_feed_id = feed_id
	  end
    	@rss_feed_entries.save
    end

  end
end