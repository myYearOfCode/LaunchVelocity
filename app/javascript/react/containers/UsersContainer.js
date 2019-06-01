import React, { Component } from 'react';
import User from "../components/User"

class UsersContainer extends Component {
  constructor(props){
    super(props);
    this.state = {
      sortByStreak: true,
      sortByGreenDays: false,
      sortByLongestStreak: false
    }
    this.fetchUsers = this.fetchUsers.bind(this);
    this.compare = this.compare.bind(this)
    this.sortUsers = this.sortUsers.bind(this)
  }

  sortUsers(event){
    this.setState({
      sortByStreak: false,
      sortByGreenDays: false,
      sortByLongestStreak: false
    });
    this.setState({ [event.target.value]: true })
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
    let output = []
    if (this.state.users && this.state.users.length > 0){
      let order = this.state.users.sort(this.compare)
      order.forEach(user => {
        output.push(<User user={user} key={user.gitHubUsername}/>)
      })
    }
    return output
  }

  componentDidMount(){
    this.fetchUsers()
  }

  render () {
    return(
      <div>
        <label>Sort Users By:</label>
        <select onChange={this.sortUsers}>
          <option value="sortByStreak">Current Streak</option>
          <option value="sortByGreenDays">Most Green Days</option>
          <option value="sortByLongestStreak">Longest Streak</option>
        </select>
        {this.renderUserComponents()}
      </div>
    )
  }
}
export default UsersContainer;
