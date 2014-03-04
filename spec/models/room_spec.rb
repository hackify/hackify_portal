require 'spec_helper'

describe Room do
  describe 'class methods' do
    before{
      test_room_state = {
        name: "testroom",
        moderatorPass: "testpass",
        readOnly: false,
        hostSocket: nil,
        authMap: {
          moderator:{editData: true, newChatMessage:true, changeUserId:true, saveCurrentFile: true, changeCurrentFile:true, changeRole:true},
          editor:{editData:true, newChatMessage:true, changeUserId:true, saveCurrentFile: true, changeCurrentFile:true, changeRole:false},
          default:{editData:true, newChatMessage:true, changeUserId:true, saveCurrentFile: true, changeCurrentFile:true, changeRole:false}
        },
        permanent: false
      }
      $redis.multi do
        #room
        $redis.del("roomState:demo")
        $redis.del("roomState:testroom")
        $redis.set("roomState:testroom", test_room_state.to_json)
        #user
        $redis.hset("user:1234", "room", "testroom")
        $redis.hset("user:1234", "userId", "testuser")
        $redis.hset("user:1234", "userInfo", "")
        $redis.hset("user:1234", "role", "default")
        $redis.hset("user:1234", "requestedRole", "")
        $redis.sadd("user:room:testroom", "1234")
        #open files
        $redis.sadd("openFile:testroom", "test.js")
      end

    }
    after{
      $redis.del("roomState:testroom")      
      $redis.del("user:1234")      
      $redis.del("user:room:testroom")      
      $redis.del("openFile:testroom")      
    }

    it "should list all the open open rooms" do
      rooms = Room.all
      #room
      expect(rooms.count).to eq 1
      #users
      expect(rooms[0].users.count).to eq 1
      expect(rooms[0].users[0]['userId']).to eq "testuser"
      #open files
      expect(rooms[0].open_files.count).to eq 1
      expect(rooms[0].open_files[0]).to eq "test.js"
    end

  end

  describe 'initialisation' do
    subject(:room) {Room.new("testroom")}
    it "should initialise correctly" do
      expect(room.name).to eq "testroom"
      expect(room.users.count).to eq 0
      expect(room.open_files.count).to eq 0
    end
  end




end
