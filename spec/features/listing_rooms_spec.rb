require 'spec_helper'

feature 'Listing the Rooms' do
  background do
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

    test_room2_state = {
      name: "testroom2",
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
      #rooms clear
      $redis.del("roomState:demo")
      #room 1
      $redis.del("roomState:testroom")
      $redis.set("roomState:testroom", test_room_state.to_json)
      #room 2
      $redis.del("roomState:testroom2")
      $redis.set("roomState:testroom2", test_room2_state.to_json)

      #user1
      $redis.hset("user:1234", "room", "testroom")
      $redis.hset("user:1234", "userId", "testuser")
      $redis.hset("user:1234", "userInfo", "")
      $redis.hset("user:1234", "role", "default")
      $redis.hset("user:1234", "requestedRole", "")
      $redis.sadd("user:room:testroom", "1234")

      #user12
      $redis.hset("user:456", "room", "testroom2")
      $redis.hset("user:456", "userId", "testuser2")
      $redis.hset("user:456", "userInfo", "")
      $redis.hset("user:456", "role", "default")
      $redis.hset("user:456", "requestedRole", "")
      $redis.sadd("user:room:testroom2", "456")

      #open files
      $redis.sadd("openFile:testroom", "test.js")
      $redis.sadd("openFile:testroom2", "teststyle.css")
    end

  end

  after do
    $redis.del("roomState:testroom")      
    $redis.del("user:1234")      
    $redis.del("user:room:testroom")      
    $redis.del("openFile:testroom")     

    $redis.del("roomState:testroom2")      
    $redis.del("user:456")      
    $redis.del("user:room:testroom2")      
    $redis.del("openFile:testroom2")     
  end

  scenario 'Reading the rooms' do
    visit "/openrooms"

    expect(page).to have_content 'Open Rooms'
    expect(page).to have_content 'testroom'
    expect(page).to have_content 'testroom2'
    expect(page).to have_content 'teststyle.css'
    expect(page).to have_content 'test.js'
    expect(page).to have_content 'testuser'
    expect(page).to have_content 'testuser2'
  end
  scenario 'Navigation to rooms' do
    visit root_path

    click_link 'Open Rooms'

    current_path.should == "/openrooms"
  end  
end
