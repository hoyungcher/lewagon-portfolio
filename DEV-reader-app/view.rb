class View
  def show_info(posts)
    posts.each_with_index do |post, index|
      read_status = post.read? ? '[x]' : '[ ]'
      puts "#{index + 1}. #{read_status} - #{post.name} (#{post.author})"
    end
  end

  def ask_for_url
    puts "Path?"
    print "https://dev.to/"
    gets.chomp
  end

  def ask_for_index(posts)
    show_info(posts)
    puts "Article number?"
    index = gets.chomp.to_i - 1
  end

  def show_content(posts, index)
    puts posts[index].content
  end
end
