require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(email: 'bobloblaw@lawblog.com', password: 'bobloblawslawblog', name: 'Bob Loblaw', username: 'bloblaw')
      persisted_data = persisted_user_data(id: user.id)
      expect(persisted_data['email']).to eq('bobloblaw@lawblog.com')
      expect(persisted_data['password']).to eq('bobloblawslawblog')
      expect(persisted_data['name']).to eq('Bob Loblaw')
      expect(persisted_data['username']).to eq('bloblaw')
    end
  end
end
