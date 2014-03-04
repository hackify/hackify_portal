class Room
  def initialize(name)
    # assign instance variables
    @name = name
    @users = []
    @open_files = []
  end

  def name
    @name
  end

  def users
    @users
  end

  def open_files
    @open_files
  end

  def self.all
    rooms = []
    room_indexes = $redis.keys("roomState:*")
    for room_index in room_indexes do
      room_name = room_index.split(/:/)[1]
      room = Room.new(room_name)

      #pull user list
      user_indexes = $redis.smembers("user:room:#{room_name}")
      for user_index in user_indexes do
        user = $redis.hgetall("user:#{user_index}")
        room.users.push(user)
      end

      # pull open files list
      open_files = $redis.smembers("openFile:#{room_name}")
      for open_file in open_files do
        room.open_files.push(open_file)
      end

      rooms.push(room)
    end

    rooms
  end
end