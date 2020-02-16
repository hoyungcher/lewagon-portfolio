class Post
  attr_reader :name, :author, :url, :content, :read
  def initialize(name, author, url, content, read)
    @name = name
    @author = author
    @url = url
    @content = content
    if read == "true"
      @read = true
    else
      @read = false
    end
  end

  def read?
    @read
  end

  def change_read!
    @read = !@read
  end
end
