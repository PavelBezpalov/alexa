# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all
events = Event.create([
  { name: 'Social tax, 2112 hrivnas', start_date: Date.parse('01.04.2017'), end_date: Date.parse('19.04.2017'), tax_group: 2 },
  { name: 'Social tax, 2112 hrivnas', start_date: Date.parse('01.07.2017'), end_date: Date.parse('19.07.2017'), tax_group: 2 },
  { name: 'Social tax, 2112 hrivnas', start_date: Date.parse('01.10.2017'), end_date: Date.parse('19.10.2017'), tax_group: 2 },
  { name: 'Social tax, 2112 hrivnas', start_date: Date.parse('01.04.2017'), end_date: Date.parse('19.04.2017'), tax_group: 3 },
  { name: 'Social tax, 2112 hrivnas', start_date: Date.parse('01.07.2017'), end_date: Date.parse('19.07.2017'), tax_group: 3 },
  { name: 'Social tax, 2112 hrivnas', start_date: Date.parse('01.10.2017'), end_date: Date.parse('19.10.2017'), tax_group: 3 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.03.2017'), end_date: Date.parse('20.03.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.04.2017'), end_date: Date.parse('20.04.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.05.2017'), end_date: Date.parse('19.05.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.06.2017'), end_date: Date.parse('20.06.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.07.2017'), end_date: Date.parse('20.07.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.08.2017'), end_date: Date.parse('19.08.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.09.2017'), end_date: Date.parse('20.09.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.10.2017'), end_date: Date.parse('20.10.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.11.2017'), end_date: Date.parse('20.11.2017'), tax_group: 2 },
  { name: 'Main tax, 640 hrivnas', start_date: Date.parse('01.12.2017'), end_date: Date.parse('20.12.2017'), tax_group: 2 },
  { name: 'Main tax, {5% from 1st quarter income} hrivnas', start_date: Date.parse('01.04.2017'), end_date: Date.parse('19.05.2017'), tax_group: 3 },
  { name: 'Main tax, {5% from 2nd quarter income} hrivnas', start_date: Date.parse('01.07.2017'), end_date: Date.parse('19.08.2017'), tax_group: 3 },
  { name: 'Main tax, {5% from 3rd quarter income} hrivnas', start_date: Date.parse('01.10.2017'), end_date: Date.parse('17.11.2017'), tax_group: 3 },
  { name: 'Main tax, {5% from 4th quarter income} hrivnas', start_date: Date.parse('01.01.2018'), end_date: Date.parse('17.02.2018'), tax_group: 3 },
  { name: 'Main tax, 2017 year report', start_date: Date.parse('01.01.2018'), end_date: Date.parse('01.03.2018'), tax_group: 2 },
  { name: 'Main tax, 1st quarter report', start_date: Date.parse('01.04.2017'), end_date: Date.parse('10.05.2017'), tax_group: 3 },
  { name: 'Main tax, 1st half-year report', start_date: Date.parse('01.07.2017'), end_date: Date.parse('09.08.2017'), tax_group: 3 },
  { name: 'Main tax, 9th months report', start_date: Date.parse('01.10.2017'), end_date: Date.parse('09.11.2017'), tax_group: 3 },
  { name: 'Main tax, 2017 year report', start_date: Date.parse('01.01.2018'), end_date: Date.parse('09.02.2018'), tax_group: 3 },
  { name: 'Social tax, 2017 year report', start_date: Date.parse('01.01.2018'), end_date: Date.parse('09.02.2018'), tax_group: 2 },
  { name: 'Social tax, 2017 year report', start_date: Date.parse('01.01.2018'), end_date: Date.parse('09.02.2018'), tax_group: 3 },
])