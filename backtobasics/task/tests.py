from django.test import TestCase, Client

class TupleTest(TestCase):
	def setUp(self):
		self.value = ('obj',True)


	def test_return_values(self):
		obj,success = self.value 
		if success:
			print 'ok'

if __name__ == '__main__':
    unittest.main()
		

