var ROUTING = (function(){
		var self = {}
		
		self.init = function(server,csrftoken){
			self.server = server
			self.csrftoken = csrftoken
		
			self.routes = {
				customer: {
					show: `${self.server}/api/customers/`,
				},
				project: {
					show: `${self.server}/api/projects/`,
				},
				task: {
					show: `${self.server}/api/tasks/`,
					create: `${self.server}/api/tasks/create/`,
					findById(id){
						return `${self.server}/api/tasks/${id}/`
					}
				},
				taskEntry: {
					show: `${self.server}/api/task/entries/`,
					create(id){
						return `${self.server}/api/task/${id}/entry/create/`
					},
					hitTimer(id){
						return `${self.server}/api/task/entries/${id}/hit-timer/`
					},
					delete(id){
						return `${self.server}/api/task/entries/delete/${id}/`
					}
				}
			}

		}
			
		return self
		
})();

var UTIL = (function(router){
	self = {}
	self.packageData = function(data){
		contents = {csrfmiddlewaretoken:router.csrftoken}
		for (var key in data){
			contents[key] = data[key]
		}
		return contents
	}
	return self
})(ROUTING);



var TASKS = (function(router,helper){
	var self = {}
	// crud
	self.show = function(){
		url = router.routes.task.show
		return $.get(url)
	}

	self.findById = function(id){
		url = router.routes.task.findById(id)
		return $.get(url)
	}

	self.create = function(data){
		data = helper.packageData(data)
		url = router.routes.task.create
		return $.post(url,data)
	}

	return self
})(ROUTING,UTIL)



var TASKENTRY = (function(router,helper){
	var self = {}
	
	// crud
		self.create = function(task_id,data){
			contents = helper.packageData(data)
			url = router.routes.taskEntry.create(task_id)
			return $.post(url,contents)
		}

		self.show = function(){
			data = helper.packageData(data)
			url = router.routes.taskEntry.show
			return $.post(url,data)
		}

		self.hitTimer = function(id){
			data = helper.packageData({})
			url = router.routes.taskEntry.hitTimer(id)
			return $.post(url,data)
		}

		self.update = function(taskEntryId){}

		self.delete = function(taskEntryId){
			data = helper.packageData({})
			url = router.routes.taskEntry.delete(id)
			return $.post(url,data)
		}
		// end crud
		return self
})(ROUTING,UTIL);




var CUSTOMERS = (function(router){
	var self = {}

	self.show = function(){
		url = router.routes.customer.show
		return $.get(url)
	}

	self.update = function(task_id){}
	self.delete = function(task_id){}

	return self

})(ROUTING);

var PROJECTS = (function(router){
	var self = {}

	self.show = function(){
		url = router.routes.project.show
		return $.get(url)
	}

	self.update = function(task_id){}
	self.delete = function(task_id){}

	return self

})(ROUTING);


var STORE = (function(){
	// private
	var self = {}
	
	self.init = function(server,token){
		ROUTING.init(server,token)
		self.projectUrl = `${server}/api/projects/`
		self.customerUrl = `${server}/api/customers/`
		self.tasksUrl = `${server}/api/tasks/`	
	}

	function STORE(server,token){
		self.init(server,token)
		this.routes = ROUTING
		// modules
		this.tasks = TASKS
		this.customers = CUSTOMERS
		this.taskEntries = TASKENTRY
		this.projects = PROJECTS

		// methods
		this.findById = function(id,objArray){
			for (var i in objArray){
				task = objArray[i]
				if (task.id === task_id) {
					return task
				}
			}
			return false
	  }

	  this.findAndDelete = function(items,id){
		for(var i =0; i< items.length;i++){
			if (items[i].id === id){
				items.splice(i, 1);
				return true
			}
		}
		return false
	}
		
		// end functions
	}
	return STORE
})(TASKENTRY,CUSTOMERS,TASKS,PROJECTS,ROUTING)
