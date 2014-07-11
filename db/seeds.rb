User.create({username: 'testuser', email: 'test@test.local', password: '12345678', phone_number: '555-555-5555', date_of_birth: DateTime.now - 100})
Group.create
GroupUser.create(user: User.first, group: Group.first)
