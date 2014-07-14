require 'rss'

module AssignmentRss
  class Source

    # This is where the party starts
    def initialize(*args)
    	@url, @max_age, @feed_class, @entry_class  = args
    end

    def url
    	@url
    end

    def max_age
    	@max_age
    end

    def feed_class
    	@feed_class
    end

    def entry_class
    	@entry_class
    end

    def get_feed
    	RSS::

  end
end