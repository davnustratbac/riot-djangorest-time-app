<autocomplete-input>
	<input onkeyup={ complete } style='margin-left: 5px;' type='text' placeholder=' search'>

<script>
	
	complete(){
		console.log(this.opts.tasks)
		console.log(this.x)
		console.log('works')
	}


</script>

</autocomplete-input>