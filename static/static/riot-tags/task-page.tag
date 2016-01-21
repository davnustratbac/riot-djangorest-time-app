<task-page>
<style type="text/css">
	.taskEntryForm{
		background-color: #50B2C4;
		padding: 20px;
		border-radius: 5px;
	}

	.wide-button{
		width: 150px;
	}
</style>
	<div class="container" style='margin-top:25px;'>
		<div class="row">
			<div class="col-md-2">
				
				<!-- task form -->
				<button onclick={ getProjects } class="btn btn-warning" data-toggle="modal" data-target="#modal-text" style='margin-bottom: 5px;'>
            create task
        </button>

        <div class="modal fade" id="modal-text" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h3 class="modal-title" id="myModalLabel3">Create Task</h3>
                </div><!-- End .modal-header -->
                <div class="modal-body">

                <!-- task form -->
                <form>
	                <select class="form-control" name='projectSelect'>
	                		<option>None</option>
	                    <option each={ project in projects }>{ project.name }</option>
	                </select>
	                	
	                <labelclass="input-desc">Name</label>
	                <input class="form-control" type="text" placeholder="Enter Name" name="taskName">

	                </div><!-- End .modal-body -->
	                <div class="modal-footer">
	                <button type="button" class="btn btn-custom" data-dismiss="modal">Close</button>
	                <button onclick={ createTask } type="submit" class="btn btn-dark" data-dismiss='modal'>Save</button>
                </form>
                <!-- end task form -->

                </div><!-- End .modal-footer -->
            </div><!-- End .modal-content -->
        </div><!-- End .modal-dialog -->
    		</div>

        <!-- tasks -->
        <div class="btn-group">
            <button type="button" class="btn btn-custom3 dropdown-toggle" data-toggle="dropdown">
            	Tasks
            	<a href="#"><span class="badge">{ count }</span></a>

            	<span class="caret"></span></button>

            	<!-- task list -->
	            <ul class="dropdown-menu pull-left" role="menu">
	            	<li class="dropdown-header">tasks: <input type='text' placeholder='search'></li>            	
	            	<li onclick={ addAnotherEntry } class='{active:task.has_entries}' each={ task in tasks }><a href="#">{ task.name }</a></li>
	            </ul>

	            <!-- add another entry modal -->
	            <div class="modal fade" id="add-another-entry-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                        <h3 class="modal-title" id="myModalLabel3">Enter Task Entry</h3>
                        </div><!-- End .modal-header -->
                        <div class="modal-body">
                        	<small>Task</small>
                        	<h2>{ task.name }</h2>
                        	<p>enter another entry for this task?</p>
                        	<button onclick={ yesAnotherEntry } class="btn btn-custom" data-dismiss="modal">Yes</button>
                        	<button onclick={ noAnotherEntry } class="btn btn-dark" data-dismiss='modal'>No</button>	
                        </div><!-- End .modal-body -->
                       
                    </div><!-- End .modal-content -->
                </div><!-- End .modal-dialog -->
            </div>


        </div>

			</div>

			<div class="col-md-10">
			
				<!-- task entry form -->
				<div if={ activateTaskEntryForm } class="col-md-6 col-md-offset-2">
					<h1 class="title-border custom mb30">Task Entry Form</h1>
					<div class='taskEntryForm'>
					<h2>Task: { task.name }</h2>
					
					<!-- form -->
					<form onsubmit={ createTaskEntry }>
						<label>notes</label>
						<textarea name='entryNote' class="form-control" rows="4" placeholder="Enter your task entry note"></textarea>
						<button type="submit" class="btn btn-danger btn-border">Create Task</button>
					</form>
					<!-- endform -->

					</div>
				</div>

				<!-- show task entries -->
				<div if={ activateTaskEntries } class="bs-example" data-example-id="simple-table"> 
						<table class="table"> 
				
							<h2 class="title-border custom title-bg-line text-center"><span>{ task.name } <small style='margin-left: 5px;'>task entries</small></span></h2>
							<thead> 
								<tr> 
									<th>clock started</th>
									<th>date</th>
									<th>last save</th>
									<th>duration</th>
									<th>note</th>
									<th>edit</th>
									<th>delete</th>
									<th>start clock</th>
								</tr> 
							</thead> 
				
							<tbody> 
								
								<tr each={ entry in taskEntries }> 
									<td>{ entry.clock_started }</td>
									<td>{ entry.date_field }</td>
									<td>{ entry.time_record }</td>
									<td>{ entry.duration_in_seconds }</td>
									<td>{ entry.note }</td>
									<td><button class='btn btn-default'>edit</button></td>
									<td><button class="btn btn-danger">Delete</button></td>
									<td><button class='btn btn-info'>Start Clock</button></td>
								</tr> 
				
								
							</tbody> 
						</table> 
					</div>
			</div>
	</div>
<script>
	// init variables
	this.activateTaskEntries = false
	this.activateTaskEntryForm = false
	this.task = null 
	this.projects = null
	this.tasks = null
	this.customers = null 

	// init
	this.on('mount',function(){
		this.opts.store.tasks.show().then((res) => {
			this.count = res.length
			this.tasks = res
			this.update()
		});
	})

	initView(e){
		if (e.item.task.has_entries) {
			this.showTaskEntries(e.item.task)
		}else{
			this.showTaskEntryForm(e.item.task)
		}
	}

	// crud task entry
	createTaskEntry(e){
		task_id = this.task.id
		data = {note:this.entryNote.value}
		// create task entry
		this.opts.store.taskEntries.create(task_id,data).then((res) => {
			task = this.opts.store.findById(task_id,this.tasks)
			if (task) {
				task.has_entries = true;
				this.update()
			}
		})
		this.activateTaskEntryForm = false
		this.update()
	}

	// crud task
	createTask(){
		ps = this.projectSelect.value;
		tn = this.taskName.value;
		this._clearTaskForm()
		data = {name:tn,project:ps}
		this.opts.store.tasks.create(data).then((task) => {
			this.tasks.push(task)
			this.count += 1
			this.update()
		})
		.fail((e) => {console.log(e)})
	}

	// actions
	addAnotherEntry(e){
		this.task = e.item.task
		if (e.item.task.has_entries) {
			$('#add-another-entry-modal').modal()
		}else{
			this.showTaskEntryForm(e.item.task)
		}
	}

	yesAnotherEntry(){
		this.showTaskEntryForm(this.task)
	}

	noAnotherEntry(){
		this.showTaskEntries()
	}

	getProjects(){
		this.opts.store.projects.show().then((res) => {
			this.projects = res
			this.update()
		})
		.fail((e) => {return e})
	}

	showTaskEntryForm(task){
		this._resetActivate()
		this.activateTaskEntryForm = true
		this.task = task 
		this.update()
	}


	showTaskEntries(task){
		riot.route('/' + this.task.id.toString())
		this._resetActivate()
		this.activateTaskEntries = true
		data = {taskID:this.task.id}
		this.opts.store.taskEntries.show().then((entries) => {
			this.taskEntries = entries
			this.update()
		}).fail((e) => {console.log(e)})
		this.update()
	}

	// private
	_resetActivate(){
		this.activateTaskEntries = false
		this.activateTaskEntryForm = false
	}

	_clearTaskForm(){
		this.projectSelect.value = null
		this.taskName.value = null
	}
</script>

</task-page>








