<alert-box>

	<div if={ activated } class="alert alert-success alert-dismissable">
	    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
	    <strong>{ success ? 'Success!' : 'Failure!' }</strong> { message }
	</div>

<script>
	self = this
	this.success = false
	this.message = null
	this.activated = false
	
	this.opts.messages.on('success',function(message){
		self.message = message
		self.success = true
		self.activated = true;
		scroll(0,0)
		self.update();
	})

	this.opts.messages.on('failure',function(message){
		this.activated = true
		this.message = message
		scroll(0,0)
		self.update()
	})

	
</script>

</alert-box>