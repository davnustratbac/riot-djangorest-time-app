<task-page>
<style type="text/css">

	.modal-button{
		min-width: 112px;
	}

	.taskEntryForm{
		background-color: #50B2C4;
		padding: 20px;
		border-radius: 5px;
	}

	.wide-button{
		width: 150px;
	}

	#search-results{
		border: 2px solid #B6C4C6; 
		position:absolute;
		width: 132px;
		margin-left: 37px;
		min-height: 20px;
		max-height: 100px;
		display: block;
		z-index: 9999;
		background-color: #E1E1E1;
		overflow: auto;
		cursor: default;
	}

	.hovered{
		background-color: #50B2C4;
	}

	.task-results{
		max-height: 300px;
		overflow: auto;
	}
</style>
	<div class="container" style='margin-top:25px;'>
		<div class="row">
			<div class="col-md-2">
				
				<!-- task form modal/button-->
				<button onclick={ getProjects } class="btn btn-warning modal-button" data-toggle="modal" data-target="#modal-text" style='margin-bottom: 5px;'>
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

                <!-- task form button/modal-->
                <form>
	                <select class="form-control" name='projectSelect'>
	                		<option>None</option>
	                    <option each={ project in projects }>{ project.name }</option>
	                </select>
	                	
	                <label class="input-desc">Name</label>
	         
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
            <button type="button" class="btn btn-custom3 dropdown-toggle modal-button" data-toggle="dropdown">
            	Tasks
            	<a href="#"><span class="badge">{ count }</span></a>

            	<span class="caret"></span></button>

            	<!-- task list dropdown-->
	            <ul class="dropdown-menu pull-left task-results" role="menu">
	            	<li class="dropdown-header">
	            		tasks: 
	            		<input onkeyup={ complete } style='margin-left: 5px;' type='text' placeholder=' search' name='autoComplete'>
	            		<div id='search-results' if={ autoCompActivated }>
	            			<ul>
	            				<li each={ result in autoCompleteRes } onmouseleave={ autoCompResMouseLeave } onmouseenter={ autoCompResMouseEnter }><a onclick={ clickAutoCompResult } href="">{ result.name }</a></li>
	            			</ul>
	            		</div>

	            	</li>            	
	            	<li onclick={ addAnotherEntry } class='{active:task.has_entries}' each={ task in tasks }><a href="#">{ task.name }<span style='float:right;' class="badge">{ task.has_entries ? task.task_entry_count : ''}</span></a></li>
	            </ul>

	            <!-- add new entry or list modal -->
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

						<table class="table table-bordered table-hover"> 
				
							<h2 class="title-border custom title-bg-line text-center"><span>{ task.name } <small>task entries</small></span></h2>
							<thead> 
								<tr> 
									<th>last save</th>
									<th>duration/sec</th>
									<th>note</th>
									<th>edit</th>
									<th>delete</th>
									<th>start clock</th>
								</tr> 
							</thead> 
				
							<tbody> 
								
								<tr each={ entry in taskEntries }> 
									<td>{ entry.datetime_last_save }</td>
									<td>{ entry.duration_in_seconds } secs</td>
									<td>{ entry.note }</td>
									<td><button onclick={ editEntry } class='btn btn-default' data-toggle="modal" data-target="#edit-entry-modal">edit</button></td>
									<td><button onclick={ deleteEntry } class="btn btn-danger">Delete</button></td>
									<td>
										<button if={ !entry.clock_started } onclick={ hitTimer } class='btn btn-info'>Start Clock</button>
										<button if={ entry.clock_started } onclick={ hitTimer } class='btn btn-dark'>
											<i class="fa fa-refresh fa-spin"></i>
											Stop Clock
										</button>
									</td>
								</tr> 
								
								<!-- edit entry modal -->
								<div class="modal fade" id="edit-entry-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
                  <div class="modal-dialog modal-sm">
                      <div class="modal-content">
                          <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                          <h3 class="modal-title" id="myModalLabel3">Edit Task Entry</h3>
                          </div><!-- End .modal-header -->
                          <div class="modal-body">

                          <label class="input-desc">Edit last save date</label>
                          <input type="datetime-local" name="dateTimeField" style='margin-bottom: 10px;'>

                          <label class="input-desc">Edit Note</label>
                          <textarea class="form-control" rows="4" placeholder="{ currentTaskEntry.note }" name="entryNoteEdit"></textarea>
                          
                          </div><!-- End .modal-body -->
                          <div class="modal-footer">
                          <button type="button" class="btn btn-custom" data-dismiss="modal">Close</button>
                          <button onclick={ initiateDateTimePicker } class="btn btn-dark">Save</button>
                          </div><!-- End .modal-footer -->
                      </div><!-- End .modal-content -->
                  </div><!-- End .modal-dialog -->
              </div>
								
							</tbody> 
						</table> 
						<h2>total duration: { taskEntryDurationCount } seconds</h2>
					</div>
			</div>
	</div>
<script>

	// init variables
	this.currentTaskEntry = null
	this.activateTaskEntries = false
	this.activateTaskEntryForm = false
	this.task = null 
	this.projects = null
	this.tasks = null
	this.taskEntries = null
	this.customers = null 
	this.isHovered = false
	this.autoCompleteRes = []
	this.autoCompActivated = false
	this.taskEntryDurationCount = 0

	// init
	this.on('mount',function(){
		this.opts.store.tasks.show().then((res) => {
			this.count = res.length
			this.tasks = res
			this.update()
		});
	})

	// crud task entry
	createTaskEntry(e){
		task_id = this.task.id
		data = {note:this.entryNote.value}
		// create task entry
		this.opts.store.taskEntries.create(task_id,data).then((res) => {
			task = this.opts.store.findById(task_id,this.tasks)
			if (task) {
				task.task_entry_count += 1
				task.has_entries = true;
				this.update()
			}
		})
		this.activateTaskEntryForm = false
		this.update()
	}

	deleteEntry(e){
		id = e.item.entry.id
		this.opts.store.taskEntries.delete(id).then((res) => {
			this.opts.store.findAndDelete(this.taskEntries,id);
			if (this.taskEntries.length === 0) {
				this.task.task_entry_count -=1
				this.task.has_entries = false
			}
			this.update()
		})
	}

	editEntry(e){
		this.currentTaskEntry = e.item.entry
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

	// timer
	hitTimer(e){
		id = e.item.entry.id
		this.opts.store.taskEntries.hitTimer(id).then((res) => {
			taskEntry = e.item.entry
			taskEntry.clock_started ? taskEntry.clock_started = false : taskEntry.clock_started = true
			if (taskEntry.clock_started === false){
				taskEntry.duration_in_seconds = res.duration_in_seconds
				this.taskEntryDurationCount += res.duration_in_seconds
			}
			this.update()
		}).fail((e) => {console.log(e)})
	}


	// autocomplete

	autoCompResMouseEnter(e){
		$(e.target).addClass('hovered')
	}

	autoCompResMouseLeave(e){
		$(e.target).removeClass('hovered')
	}

	clickAutoCompResult(e){
		e.preventDefault()
		this.task = e.item.result
		this.addAnotherEntry(e)
		this.autoComplete.value = null
		this.autoCompActivated = false
	}

	// actions
	initiateDateTimePicker(){
		 note = this.entryNoteEdit.value
		 datetime = this.dateTimeField.value
		 console.log(note)
		 console.log(datetime)
	}

	complete(e){
		word = e.target.value
		wordLen = word.length 

		if (word.length >= 2){
			foundResults = []
			for (var i in this.tasks){
				taskName = this.tasks[i].name 
				if (word === taskName.slice(0,wordLen)){
					this.autoCompActivated = true
					foundResults.push(this.tasks[i])
				}
			}
			this.autoCompleteRes = foundResults
		}else if (word.length === 0){
			this.autoCompActivated = false
			this.autoCompleteRes = []
		}
	}

	addAnotherEntry(e){
		e.item.result ? this.task = e.item.result :	this.task = e.item.task
		this.task.has_entries ? $('#add-another-entry-modal').modal() : this.showTaskEntryForm(this.task)
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
		if (this.task === null){
			resultTask = task
		}else{
			resultTask = this.task
		}

		self.opts.messages.trigger('fillAutoCompleteTag',{data:this.tasks})
		riot.route('/' + resultTask.id.toString())
		this._resetActivate()
		this.activateTaskEntries = true
		data = {taskID:resultTask.id}
		this.opts.store.taskEntries.show().then((entries) => {
			this.taskEntries = entries
			this.sumEntryDurations(entries)
			this.update()
		}).fail((e) => {console.log(e)})
		this.update()
	}

	sumEntryDurations(entries){
		for (var i in entries) {
			entry = entries[i]
			this.taskEntryDurationCount += entry.duration_in_seconds
		}
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








