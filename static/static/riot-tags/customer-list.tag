<customer-list>
<div class="mb40"></div><!-- space -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="col-sm-12">
                        <h2 class="title-border custom mb40">Table Row Colored</h2>
                        <div class="table-responsive">
                            <table class="table table-colored table-bordered table-condensed">
                                <thead>
                                    <tr class="danger">
																			<th>company</th> 
																			<th>address1</th> 
																			<th>address2</th> 
																			<th>address3</th> 
																			<th>city</th>    
																			<th>state</th>   
																			<th>zip</th>     
																			<th>phone1</th>  
																			<th>phone2</th>  
																			<th>fax1</th>    
																			<th>fax2</th>    
																			<th>email</th>   
																			<th>url</th>     
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr each={ customer in customers }>
                                      <td>{ customer.company }</td> 
																			<td>{ customer.address1 }</td> 
																			<td>{ customer.address2 }</td> 
																			<td>{ customer.address3 }</td> 
																			<td>{ customer.city }</td>    
																			<td>{ customer.state }</td>   
																			<td>{ customer.zip }</td>     
																			<td>{ customer.phone1 }</td>  
																			<td>{ customer.phone2 }</td>  
																			<td>{ customer.fax1 }</td>    
																			<td>{ customer.fax2 }</td>    
																			<td>{ customer.email }</td>   
																			<td>{ customer.url }</td>     
                                    </tr>
                                </tbody>
                            </table>
                        </div><!-- End .table-responsive -->
                    </div>
			</div>
		</div>
	</div>
<script>
	this.customers = null
	this.on('mount',function(){
		this.opts.store.customers.show().then((customers) => {
			console.log(customers)
			this.customers = customers 
			this.update()
		})
		.then((e) => {console.log(e)})
	});
</script>

</customer-list>