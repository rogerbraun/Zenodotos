(function($) {
		  
	$.fn.select_autocomplete = function(options) {
		
		// make sure we have an options object
		options = options || {};
		
		// setup our defaults
		var defaults = { 
		};
		
		options = $.extend(defaults, options);
		
		return this.each(function() {
		
			//stick each of it's options in to an items array of objects with name and value attributes 
			var $this = $(this),
				data = [],
				$input = $('<input type="text" />');
			
			if (this.tagName.toLowerCase() != 'select') { return; }
				
			
			$this.children('option').each(function() {
		
				var $option = $(this);
				
				if ($option.val() != '') { //ignore empty value options

					data.push({
						  label: $option.html()
						, value: $option.val()
					});
				}
			});
			
			// insert the input after the select
			$this.after($input);
			
			// add it our data
			options.source = data;
		
			//make the input box into an autocomplete for the select items
			$input.autocomplete(options);
		
			//make the result handler set the selected item in the select list
			$input.bind("autocompleteselect", function(event, ui) { 
				$($this.find('option[value=' + ui.item.value + ']')[0]).attr('selected', true);
        $input.val(ui.item.label);
        return false;
			});

      $input.blur(function(){
          // autocomplete has removed blank options
          // ensure that if value is removed we select the blank option if available
          if(this.value == ""){
            $($this.find('option[value=]')[0]).attr('selected', true);
          }

          /*   failsafe to ensure text box always represents the value being used in the select
           *   there are edge cases where if you leave the field part way through the word, or clear the value when no blank option is available
           *   that force a mismatch between the 2 elements
           */
          if(this.value != $this[0].options[$this[0].selectedIndex].text){
            $input.val($this[0].options[$this[0].selectedIndex].text);
          }  
      });
		
			//set the initial text value of the autocomplete input box to the text node of the selected item in the select control
			$input.val($this[0].options[$this[0].selectedIndex].text);
		
			$this.hide();
		});
	};		  
  
})(jQuery);
