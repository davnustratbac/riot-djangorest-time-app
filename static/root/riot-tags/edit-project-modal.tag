<edit-project-modal>
<button class="btn btn-info" data-toggle="modal" data-target="#edit-modal" onclick={ editProject }>
   Edit 
</button>

		<div class="modal fade" id="edit-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3">

        <div class="modal-dialog modal-sm">

            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h3 class="modal-title">Edit <br>{ customerName }</h3>
                </div><!-- End .modal-header -->
                <div class="modal-body">

                <form>
                
                <label>Project</label>
  						  <input value="" class="form-control" type="text" placeholder="{ projectName }" name='project'>
                
                </div><!-- End .modal-body -->
                <div class="modal-footer">
                <button type="button" class="btn btn-custom" data-dismiss="modal">Close</button>
                <button class="btn btn-dark">Save</button>
                </form>
                </div><!-- End .modal-footer -->
            </div><!-- End .modal-content -->
        </div><!-- End .modal-dialog -->
    </div>
	
<script>
	this.projectName = null
	this.customerName = null

	editProject(){
		this.projectName = null
		this.customerName = null 

		$.get('http://localhost:8000/api/project/' + opts.project).then((res) => {
			console.log(res)
			this.projectName = res.name
			this.customerName = res.customer.company
			this.update()
		})
		.fail((e) => {
			console.log(e)
		})
	}
</script>

</edit-project-modal>
