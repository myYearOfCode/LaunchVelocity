import React, { Component } from 'react';


import User from "../components/User"
import UpdateUser from "../components/UpdateUser"

class UsersContainer extends Component {
  constructor(props){
    super(props);
    this.state = {
      users: [],
      sortByStreak: true,
      sortByGreenDays: false,
      sortByLongestStreak: false,
      sendReminders: false
    }
    this.fetchUsers = this.fetchUsers.bind(this);
    this.compare = this.compare.bind(this)
    this.sortUsers = this.sortUsers.bind(this)
    this.handleConsumedChange = this.handleConsumedChange.bind(this);
    this.handleUserFormSubmit = this.handleUserFormSubmit.bind(this);
  }

  sortUsers(event){
    this.setState({
      sortByStreak: false,
      sortByGreenDays: false,
      sortByLongestStreak: false
    });
    this.setState({ [event.target.value]: true });
  }

  compare(a, b){
     if (this.state.sortByStreak) {
      return b.currentStreak - a.currentStreak
    } else if (this.state.sortByGreenDays) {
      return b.totalGreenDays - a.totalGreenDays
    } else {
      return b.longestStreak - a.longestStreak
    }
  }

  fetchUsers() {
    fetch('/api/v1/users')
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
      this.setState({users: body})
    })
    .catch(error => console.error( `Error in fetch: ${error.message}` ));
  }

  renderUserComponents() {
    if (this.state.users.length > 0){
      let sorted = this.state.users.sort(this.compare)
      let output = sorted.map(user => {
        return (<User user={user} key={user.gitHubUsername}/>)
      })
      return output
    }
  }

  componentDidMount(){
    this.fetchUsers()
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
    fetch("/api/v1/users/22",{
      method: 'PATCH',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({
        user: {
          gitHubUsername: this.state.gitHubUsername,
          sendReminders: this.state.sendReminders,
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

  render () {
    return(
      <div>
      <UpdateUser
        handleConsumedChange = {this.handleConsumedChange}
        handleUserFormSubmit = {this.handleUserFormSubmit}
        email = {this.state.email || ""}
        gitHubUsername = {this.state.gitHubUsername || ""}
        sendReminders = {this.state.sendReminders || ""}
      />
        <div className="introBar">
          <div className="aboutMe">
            This site is set up to visualize commits for the members of <a href="https://launchacademy.com/" >Launch Academy's </a> cohort 24. It helps to gamify our continued coding efforts and keeps it fun! You can filter by a few different measures and then click on photos or usernames to check out the actual github repos.
          </div>
          <div className="filterSelectorDiv">
            <label>Sort Users By:</label>
            <select className="filterSelector" onChange={this.sortUsers}>
              <option value="sortByStreak">Current Streak</option>
              <option value="sortByGreenDays">Most Green Days</option>
              <option value="sortByLongestStreak">Longest Streak</option>
            </select>
          </div>
        </div>
        {this.renderUserComponents()}
      </div>
    )
  }
}
export default UsersContainer;
