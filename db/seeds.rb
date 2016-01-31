# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
DEFAULT_INSECURE_PASSWORD = 'matej123'

User.create({
                first_name: 'Matej',
                last_name: 'Chalachan',
                nick_name: 'Payne',
                email: 'matejchalachan@gmail.com',
                password: DEFAULT_INSECURE_PASSWORD,
                password_confirmation: DEFAULT_INSECURE_PASSWORD
            })

User.create({
                first_name: 'Tomas',
                last_name: 'Truben',
                nick_name: 'tomas',
                email: 'tomas@teamtreehouse.com',
                password: DEFAULT_INSECURE_PASSWORD,
                password_confirmation: DEFAULT_INSECURE_PASSWORD
            })

User.create({
                first_name: 'Vlado',
                last_name: 'Krejci',
                nick_name: 'Vladislav',
                email: 'krejci.vlado@gmail.com',
                password: DEFAULT_INSECURE_PASSWORD,
                password_confirmation: DEFAULT_INSECURE_PASSWORD
            })


matej = User.find_by_email('matejchalachan@gmail.com')
tomas   = User.find_by_email('tomas@teamtreehouse.com')
vlado  = User.find_by_email('krejci.vlado@gmail.com')


seed_user = matej

seed_user.statuses.create(content: 'Hello, pani!')
tomas.statuses.create(content: 'Hi, I\'m Tomasko')
vlado.statuses.create(content: 'Hello from the HELL!')

UserFriendship.request(seed_user, tomas).accept!
UserFriendship.request(seed_user, vlado).block!

