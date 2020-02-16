require 'csv'

class Library
  def initialize(csv_file)
    @csv_file = csv_file
    @library = []
    load_csv(csv_file)
  end

  def load_csv(csv_file)
    CSV.foreach(csv_file) do |row|
      add_post(Post.new(row[1], row[3], row[0], row[2], row[4]))
    end
  end

  def all
    @library
  end

  def add_post(new_post)
    @library << new_post
    save_changes_to_csv
  end

  def save_changes_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @library.each do |post|
        csv << [post.url, post.name, post.content, post.author, post.read?]
      end
    end
  end
end
