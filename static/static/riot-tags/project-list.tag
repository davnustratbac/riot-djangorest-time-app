<project-list>
<div class="container" style='margin-top: 25px;'>
<div class="row">
	
	<div class="col-md-2">
		<button class="btn btn-warning" data-toggle="modal" data-target="#modal-text">
        create project
    </button>

    <div class="modal fade" id="modal-text" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
      <div class="modal-dialog modal-sm">
          <div class="modal-content">
              <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              <h3 class="modal-title" id="myModalLabel3">create project</h3>
              </div><!-- End .modal-header -->
              <div class="modal-body">

              <form onsubmit={ saveProject }>
              
              <label>Customer Name</label>
              <select class="form-control" name='customerSelect'>
              		<option>None</option>
                  	<option each={ customer in customers }>{ customer.company }</option>
              </select>

              <label>Project Name</label>
              <input class="form-control" type="text" placeholder="Enter Project Name" name='projectName'>
              
              </div><!-- End .modal-body -->
              
              <div class="modal-footer">
              <button type="button" class="btn btn-custom" data-dismiss="modal">Close</button>
              <button onclick={ saveProject } data-dismiss="modal" type="submit" class="btn btn-dark">Save</button >
              </form>
              </div><!-- End .modal-footer -->
          </div><!-- End .modal-content -->
      </div><!-- End .modal-dialog -->
  </div>
	</div>


	<div class="col-md-8">
		
		<div class="bs-example" data-example-id="simple-table" > 
				<table class="table"> 
		
					<h1>Project List</h1>
					
					<thead> 
						<tr> 
							<th>Project Name</th>
							<th>Customer</th>
							<th>Edit</th>
							<th>Delete</th>
						</tr> 
					</thead> 
		
					<tbody> 

						<tr each={ project in projects }> 
							<td>{ project.name }</td>
							<td>{ project.customer.company }</td>
				
							<td>
								<button onclick={ getProject } class="btn btn-info" data-toggle="modal" data-target="#edit-modal" >Edit</button>

							<div class="modal fade" id="edit-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3">

					        <div class="modal-dialog modal-sm">

					            <div class="modal-content">
					                <div class="modal-header">
					                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
					                <h3 class="modal-title">Edit Name<br></h3>
					                </div><!-- End .modal-header -->

					                <div class="modal-body">

					                <label>Customer Name</label>
						              <select class="form-control" name='select'>
						              		<option>{ modalProject.customer.company }</option>
						              </select>
					                
					                <label>Project</label>
					  						  <input value="" class="form-control" type="text" placeholder="{ modalProject.name }" name='project'>
					                
					                </div><!-- End .modal-body -->
					                <div class="modal-footer">
					                <button type="button" class="btn btn-custom" data-dismiss="modal">Close</button>
					                <button class="btn btn-dark">Save</button>
					                </form>
					                </div><!-- End .modal-footer -->
					            </div><!-- End .modal-content -->
					        </div><!-- End .modal-dialog -->
					    </div>
							</td>
							<td><a onclick={ deleteProject } href="" class="btn btn-danger">Delete</a></td>
						</tr> 
						
		
						
					</tbody> 
				</table> 
			</div>
			

	</div>
	
  
</div>

</div>
	
<script>
	this.projects = null
	this.modalProject = null 
	this.areProjects = false

	this.on('mount',function(){
		projectUrl = 'http://localhost:8000/api/projects/'
		customerUrl = 'http://localhost:8000/api/customers/'
		
		$.get(projectUrl).then((res) => {
			this.projects = res
			this.update()

		})

		$.get(customerUrl).then((res) => {
			this.customers = res
			this.update()
		});

	})



	saveProject(){
		$('#modal-text').modal('hide');

		customer = this.customerSelect.value
		name = this.projectName.value
		token = Cookies.get('csrftoken')
		data = {customer:customer,name:name,csrfmiddlewaretoken:token}

		url = 'http://localhost:8000/api/projects/create/'
		$.post(url,data).then((project) => {
			this.projects.push(project)
			this.update()
		})
		.then(() => {
			this._resetForm()
		})
		.fail((e) => {
			console.log(e)
		});
		this.update()
	}

	deleteProject(e){
		id = e.item.project.id
		url = 'http://localhost:8000/api/projects/delete/' + id + '/'
		data = {csrfmiddlewaretoken:Cookies.get('csrftoken')}
		$.post(url,data).then((res) => {
			deleted = this._findAndDelete(this.projects,id)
			if (deleted){
				this.opts.messages.trigger('success',res)
				scroll(0,0)
			}
		})
		.fail((e) => {
			
		})
	}

	getProject(e){
		id = e.item.project.id.toString()
		$.get('http://localhost:8000/api/project/' + id).then((res) => {
			this.modalProject = res 
			this.update()
		});
	}
	
	//---------------------------------------------
	// private
	//---------------------------------------------
	
	
	_resetForm(){
		this.customerSelect.value = 'None'
		this.projectName.value = null
	}

	_findAndDelete(items,id){
		for(var i =0; i< items.length;i++){
			if (items[i].id === id){
				items.splice(i, 1);
				this.update()
				return true
			}
		}
		return false
	}
</script>

</project-list>