// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "json" ]
  greet(data) {
    
    let the_response = data.detail[2].response
    
    document.getElementById("json").innerHTML = the_response;
    document.getElementById("next_section").innerHTML = "You may now continue to the next section/assignment"
    document.getElementById("the_next_section").removeAttribute("disabled"); 
    //document.getElementById('the_next_section').disabled = "enabled";
    // $(#'the_next_section').removeAttr('disabled');
    //$('#the_next_section').prop("disabled", false);
  }
}
