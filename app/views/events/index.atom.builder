atom_feed do |feed|
  feed.title "Hackify.org Events"
  feed.updated @events.first.updated_at
  
  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title event.title
      entry.content event.body, :type => 'html'

      entry.author do |author|
        author.name 'Michael Dausmann'
      end
    end
  end
end