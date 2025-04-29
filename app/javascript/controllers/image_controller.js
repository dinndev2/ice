import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["displayer", "errorMessage"]


  now(event) {
    const uploader = event.currentTarget;
    // extract image from input file on change
    const file = uploader.files[0];
    
    // attach the "to" upload file in preview container
    if(file) {
      const reader = new FileReader();
      if (!file.type.match('image.*')) {
        this.displayerTarget.innerHTML = ''; // Clear preview
        this.errorMessageTarget.textContent = 'Please upload a valid image file (PNG, JPG, JPEG, or GIF).';
        event.currentTarget.value = ''; // Clear the wrong file
      } 
      else {
        reader.onload = ((e) => {
          this.displayerTarget.src = e.target.result
          this.displayerTarget.width = 150; // Set desired width
          this.displayerTarget.height = 150
        });

        reader.readAsDataURL(file)
      }
    }
  }
}