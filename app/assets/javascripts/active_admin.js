//= require active_admin/base
//= require jquery-ui
//= require jquery_ujs
//= require ckeditor/init

$(document).ready(function() { 
  $(".slug_input").keyup(function(){
      $parent_field = $(this).parents(".inputs.locale")
      var Text = $(this).val();
      
      $.ajax({
        url: '/admin/pages/string_to_friendly_url?format=json',
        data: {text: Text},
          success:function (data, status) {
             $(".slug_output").val(data.data);
       }
      })
  });
  


});
