from django.test import TestCase, Client
import pandas as pd
from models import Customer 

class FundraiserTest(TestCase):
	def setUp(self):
		pass


	def test_upload_csv(self):
		file = '/Users/mzakany/Desktop/backtobasics/backtobasics/customer/customers.csv'
		df = pd.read_csv(file)

		for row in df.iterrows():
			company = row[1][0]
			address1 = row[1][1]
			address2 = row[1][2]
			address3 = row[1][3]
			city = row[1][4]   
			state = row[1][5]  
			zip = row[1][6]    
			phone1 = row[1][7] 
			phone2 = row[1][8] 
			fax1 = row[1][9]   
			fax2 = row[1][10]   
			email = row[1][11]  
			url = row[1][12]

			Customer.objects.create(company=company, address1=address1, address2=address2, address3=address3, city=city,    state=state,   zip=zip,     phone1=phone1,  phone2=phone2,  fax1=fax1,    fax2=fax2,    email=email,   url=url    )


if __name__ == '__main__':
    unittest.main()
		

