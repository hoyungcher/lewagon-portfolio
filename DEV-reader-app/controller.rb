require_relative 'post.rb'
require_relative 'view.rb'
require_relative 'scraper.rb'

class Controller
  def initialize(library)
    @library = library
    @view = View.new
  end

  def list
    posts = @library.all
    @view.show_info(posts)
  end

  def save
    url = @view.ask_for_url
    new_scraper = Scraper.new(url)
    new_post = Post.new(new_scraper.name, new_scraper.author, new_scraper.url, new_scraper.content, false)
    @library.add_post(new_post)
  end

  def read
    posts = @library.all
    index = @view.ask_for_index(posts)
    @view.show_content(posts, index)
    posts[index].change_read! if posts[index].read? == false
    @library.save_changes_to_csv
  end

  def mark_or_unmark
    posts = @library.all
    index = @view.ask_for_index(posts)
    posts[index].change_read!
    @library.save_changes_to_csv
  end
end
