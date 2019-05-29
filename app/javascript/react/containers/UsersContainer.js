import React, { Component } from 'react';
import User from "../components/User"

class UsersContainer extends Component {
  constructor(props){
    super(props);
    this.state = {
      recipeName: ''
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
    this.state.users.forEach(user => {
      output.push(<User user={user}/>)
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
        hello world
        {this.renderUserComponents()}
      </div>
    )
  }
}
export default UsersContainer;
