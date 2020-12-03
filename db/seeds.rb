User.destroy_all
Day.destroy_all
Entry.destroy_all

#seed a user
dain = User.create
dain.name = "Dain"
dain.save

#seed 2 days
dec3 = Day.create
dec3.month = 12
dec3.day = 3
dec3.save

dec15 = Day.create
dec15.month = 12
dec15.day = 15
dec15.save

#seed entries
e1 = Entry.create
e1.start_time = 540
e1.end_time = 570
e1.description = "meeting"
e1.user_id = dain.id
e1.day_id = dec3.id
e1.save

e2 = Entry.create
e2.start_time = 630
e2.end_time = 660
e2.description = "lunch with mom"
e2.user_id = dain.id
e2.day_id = dec3.id
e2.save




