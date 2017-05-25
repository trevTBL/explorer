module Explorer
	module ApplicationHelper
		def full_title(page_title = '')
	    base_title = "Black Tech Event Calendar"
	    if page_title.empty?
	      base_title
	    else
	      "#{page_title} | #{base_title}"
	    end
	  end

	  def default_description(page_description = '')
	    base_description = "Curated Events For Tech Geeks."
	    if page_description.empty?
	      base_description
	    else
	      "#{page_description} "
	    end
	  end

	  def default_url(page_url = '')
	    base_url = root_url
	    if page_url.empty?
	      base_url
	    else
	      "#{page_url} "
	    end
	  end

	  def default_image(page_image = '')
	    base_image = image_url('fallback/default.png') 
	    if page_image.empty?
	      base_image
	    else
	      "#{page_image} "
	    end
	  end

	  def default_twitter(page_twitter = '')
	    base_twitter = 'geeknocity' 
	    if page_twitter.empty?
	      base_twitter
	    else
	      "#{page_twitter} "
	    end
	  end
	end
end