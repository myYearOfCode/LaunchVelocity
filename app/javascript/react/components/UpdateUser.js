import React, { Component } from 'react';

import TextField from "./TextField"
import 'react-phone-number-input/style.css'
import PhoneInput from 'react-phone-number-input'

class UpdateUser extends Component {
  constructor(props){
    super(props);
    this.state = {
    }
    this.handleConsumedChange = this.handleConsumedChange.bind(this);
    this.handleUserFormSubmit = this.handleUserFormSubmit.bind(this);
  }

  componentDidMount(){
    fetch('/api/v1/current_user')
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText}) ,`
        let error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(body => {
      this.setState({id: body.id, gitHubUsername: body.gitHubUsername, email: body.email, sendReminders: body.sendReminders, phone: body.phone_number})
    })
    .catch(error => console.error( `Error in fetch: ${error.message}` ));
  }

  handleConsumedChange(event) {
    if (event.target.name === "sendReminders") {
      this.setState({ [event.target.name]: !this.state.sendReminders })
    }
    else {
      this.setState({ [event.target.name]: event.target.value })
    }
  }

  readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(";");
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) === " ") c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }

  handleUserFormSubmit(event){
    event.preventDefault()
    const token = decodeURIComponent(this.readCookie("X-CSRF-Token"));
    console.log("submitting form")
    fetch(`/api/v1/users/${this.state.id}`,{
      method: 'PATCH',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({
        user: {
          phone_number: this.state.phone,
          gitHubUsername: this.state.gitHubUsername,
          sendReminders: this.state.sendReminders ? "true" : "false",
          email: this.state.email
        }
      })
    })
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status}(${response.statusText})` ,
        error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(body => {
      console.log(body)
      window.location.reload()
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  getCheckboxStatus() {
    if (this.state.sendReminders === true){
      return(
        "checked"
      )
    }
  }

  render () {
    console.log(this.state.phone)
    return(
      <div className="form_wrapper">
        <div className="edit_user">
          <form className="callout" onSubmit={this.handleUserFormSubmit}>
            <TextField
              content={this.state.gitHubUsername || ""}
              label='github username'
              name='gitHubUsername'
              handlerFunction={this.handleConsumedChange}
            />
            <TextField
              content={this.state.email || ""}
              label='email address'
              name='email'
              handlerFunction={this.handleConsumedChange}
            />
            <PhoneInput
              showCountrySelect={false}
              country="US"
              placeholder="Enter phone number"
              value={ this.state.phone }
              onChange={ phone => this.setState({ phone }) }
            />
           <input
             type="checkbox"
             name="sendReminders"
             onChange={this.handleConsumedChange}
             checked={this.getCheckboxStatus()}
           />
           Send me reminders.
           <br/>
           <input type="submit" value="Submit"/>
          </form>
        </div>
      </div>
    )
  }
}
export default UpdateUser;
