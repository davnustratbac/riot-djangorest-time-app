from models import Task,TaskEntry
import time as iwantto
from django.utils import timezone
from datetime import datetime,date,time

from django.test import TestCase, Client

class TupleTest(TestCase):
	def setUp(self):
		task = Task.objects.create(name='new task')
		self.te = TaskEntry(task=task)

	def test_time(self):
		self.te.start()
		c = self.te.clock_started
		t = self.te.time_record
		
		hour,min,sec = t.hour,t.minute,t.second
		formatted_time = time(hour,min,sec)
		
	def test_date(self):
		self.te.start()
		datetime.combine(self.te.date_field,self.format_time(self.te.time_record))
	
	def format_time(self,t):
		hour,min,sec = t.hour,t.minute,t.second
		return time(hour,min,sec)

	def test_subtract_dates(self):
		self.te.start()
		df = self.te.date_field
		ft = self.format_time(self.te.time_record)
		diff = datetime.now() - datetime.combine(df,ft)
		diff.seconds


	def test_edit_data(self):
		dt = datetime.strptime('2016-01-21T22:50',"%Y-%m-%dT%H:%M")
		time = dt.time()
		date = dt.date()









		

















if __name__ == '__main__':
    unittest.main()
		

