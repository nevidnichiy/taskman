// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$.ready(
  function(){
    $('.j-completed input').click(
      function(e){
        var taskId = $(this).data("task");
        $.post("/tasks/complete_task", {
          task_id: taskId,
        }).then(
          function(response){
            var data = JSON.parse(response);
            if(data.completed){
              $('#row_'+taskId).addClass('completed');
            }else{
               $('#row_'+taskId).removeClass('completed');
            }
          },
          function(xhr){
              console.log(xhr.status, xhr.statusText);
          }
        )
      }
    )
    $(".j-up,.j-down").click(function(){
        var row = $(this).parents("tr");
        var position;
        if ($(this).is(".j-up")) {
            position = 'up';
            row.insertBefore(row.prev());
        } else {
            position = 'down';
            row.insertAfter(row.next());
        }
        $.post("/tasks/update_positions",
          {
            current_row: row.data("rowid"),
            position: position,
          }
        );
    });
  }
)